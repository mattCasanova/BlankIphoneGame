/******************************************************************************/
/*
 File:   Sound.m
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/06/03
 
 The sound class is resposible for playing sound effects.  For now only short
 sound clips sould be played.  Background music should be no more than 30secs
 and looped.
 */
/******************************************************************************/
#import "Sound.h"

#import <OpenAl/al.h>
#import <OpenAl/alc.h>
#include <AudioToolbox/AudioToolbox.h>

#define SAMPLE_RATE            44100
#define MAX_BUFFERS            256
#define MAX_CONCURRENT_SOURCES 32
#define DEFAULT_GAIN           1.0f
#define DEFAULT_PTICH          1.0f


//private data
@interface Sound ()
{
  ALCdevice*           m_audioDevice;
  ALCcontext*          m_audioContext; /* The context we are using */
  NSMutableDictionary* m_sampleBuffers;/* Preloaded audio sample buffers. */
  NSMutableArray*      m_sampleSources;/* Preloaded audio samples sources. */
  
  bool* s_pIsSoundOn;

}
//private functions
-(BOOL)initOpenAL;
-(ALuint)getSource;
-(UInt32)getSizeOfAudioComponent:(AudioFileID)fileID;
-(AudioFileID)openAudioFile:(NSString *)fileName;

@end
void InterruptionCallback(void* userData, UInt32 state);

@implementation Sound
void InterruptionCallback(void* userData, UInt32 state)
{
  if (kAudioSessionBeginInterruption == state)
  {
    /* There is no need to deactivate the Audio Session. This happens automatically.
     We do have to make sure we give up the context.
     */
    alcMakeContextCurrent(NULL);
  }
  else if (kAudioSessionEndInterruption == state)
  {
    /* After the interruption is over, reactivate our Audio Session
     and take back the context.
     */
    AudioSessionSetActive(true);
    ALCcontext* context = (ALCcontext*)userData;
    alcMakeContextCurrent(context);
  }
}

/******************************************************************************/
/*
   Initilizes private data and openAL
 */
/******************************************************************************/
-(Sound*)init
{
  self = [super init];
  if (!self)
    return nil;
  
  /* Initialise audio sample buffers and sources. */
  m_sampleBuffers = [[NSMutableDictionary alloc] init];
  m_sampleSources = [[NSMutableArray alloc] init];
    
  /* Initialise OpenAL. */
  BOOL result = [self initOpenAL];
  if (!result)
    return nil;
  
  return self;
}
/******************************************************************************/
/*
 Helper funciton to init the openAL part of the Sound class
 */
/******************************************************************************/
- (BOOL)initOpenAL
{
  /* Setup the Audio Session and monitor interruptions */
  AudioSessionInitialize(NULL, NULL, InterruptionCallback, m_audioContext);
  
  /* Set the category for the Audio Session */
  UInt32 session_category = kAudioSessionCategory_MediaPlayback;
  AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(session_category), &session_category);
  
  /* Make the Audio Session active */
  AudioSessionSetActive(true);
  
  /* The device is a physical thing, like a sound card. 'NULL' indicates that 
   we want the default device */
  m_audioDevice = alcOpenDevice(NULL);
  
  if (!m_audioDevice)
    return NO;
  
  /* The context is used to track the state of OpenAL. We need to create a 
   single context and associate it with the device. */
  m_audioContext  = alcCreateContext(m_audioDevice, NULL);
  
  if(!m_audioContext)
    return NO;
    
  /* Set the context we just created to the current context. Note: we will need
   monitor app state to manage the current context */
  alcMakeContextCurrent(m_audioContext);
    
  /* Generate the sound sources which will be used to play concurrent sounds. */
  ALuint sourceID;
  for (int i = 0; i < MAX_CONCURRENT_SOURCES; i++)
  {
    /* Create a single OpenAL source */
    alGenSources(1, &sourceID);
    /* Add the source to the audioSampleSources array */
    [m_sampleSources addObject:[NSNumber numberWithUnsignedInt:sourceID]];
  }
    
  /* OpenAL has been setup successfully */
  return YES;
}
/******************************************************************************/
/*
 Cleans up resources related to the sound class
 */
/******************************************************************************/
-(void)dealloc
{
  /* Stop playing any sounds and delete the sources */
  ALint source;
  for (NSNumber* sourceValue in m_sampleSources)
  {
    ALuint sourceID = [sourceValue unsignedIntValue];
    alGetSourcei(sourceID, AL_SOURCE_STATE, &source);
    alSourceStop(sourceID);
    alDeleteSources(1, &sourceID);
  }
  [m_sampleSources removeAllObjects];
  
  /* Delete the buffers */
  NSArray* bufferIDs = [m_sampleBuffers allValues];
  for (NSNumber* bufferValue in bufferIDs)
  {
    ALuint bufferID = [bufferValue unsignedIntValue];
    alDeleteBuffers(1, &bufferID);
  }
  [m_sampleBuffers removeAllObjects];
  
  alcDestroyContext(m_audioContext);/* Give up the context */
  alcCloseDevice(m_audioDevice);/* Close the device */
}
/******************************************************************************/
/*
 Finds the first source that is not current playint any audio sample. To do
 this, we will query to state of each source in the m_sampleSources array
 */
/******************************************************************************/
- (ALuint) getSource
{
  ALint sourceState;
  for (NSNumber* sourceID in m_sampleSources) {
    alGetSourcei([sourceID unsignedIntValue], AL_SOURCE_STATE, &sourceState);
    if (sourceState != AL_PLAYING)
      return [sourceID unsignedIntValue];
  }
  
  /* If we do not find an unused source, use the first source in the 
     audioSampleSources array. 
  */
  NSNumber* value = [m_sampleSources objectAtIndex:0];
  ALuint sourceID = [value unsignedIntValue];
  alSourceStop(sourceID);
  return sourceID;
}
/******************************************************************************/
/*
 With the audio file open, get the file size. 
 
 Note: the audio file contains a lot of information in addition to the actual 
 audio. We only want to know how large the audio portion of the file is.
 
 When getting properties, you provide a reference to a variable containing 
 the size of the property value. this variable is then set to the actual 
 size of the property value.
 */
/******************************************************************************/
- (UInt32)getSizeOfAudioComponent:(AudioFileID)fileID
{

  UInt64 audioDataSize = 0;
  UInt32 propertySize = sizeof(UInt64);
  
  OSStatus result = AudioFileGetProperty(fileID,
                                        kAudioFilePropertyAudioDataByteCount,
                                        &propertySize,
                                        &audioDataSize);
  
  NSAssert(result != 0, @"Couldn't get the size of audio file");
  return (UInt32)audioDataSize;
}
/******************************************************************************/
/*
 Open the audio file and return an AudioFileID
 */
/******************************************************************************/
-(AudioFileID)openAudioFile:(NSString*)fileName
{
  /* Convert the string into a URL. */
  NSURL* audioFileURL = [NSURL fileURLWithPath:fileName];
  
  /* Open the audio file and read in the data to an AudioFileID.
   
   CFURLRef inFileRef             = the file URL <- Note: __bridge is used for ARC
   SInt8 inPermissions            = the permissions used for opening the file
   AudioFileTypeID inFileTypeHing = a hint for the file type. Note: '0' indicates that we are not providing a hint
   AudioFileID* outAudioFile      = reference to the audio file
   */
  AudioFileID fileID;
  OSStatus result = AudioFileOpenURL((__bridge CFURLRef)audioFileURL,
                                     kAudioFileReadPermission,
                                     0,
                                     &fileID);
  
  /* Check to make sure the file opened properly. */
  NSAssert(result != 0, @"Couldn't open the audio file %@:", fileName);
  return fileID;
}
/******************************************************************************/
/*
 Description of how I want the status bar to behave in my game
 */
/******************************************************************************/
-(int)loadSound:(NSString*)fileName
{
  return 0;
}
/******************************************************************************/
/*
 Description of how I want the status bar to behave in my game
 */
/******************************************************************************/
-(void)playSound:(int)soundID
{
  
}

@end