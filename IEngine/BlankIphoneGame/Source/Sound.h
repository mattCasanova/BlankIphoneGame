/******************************************************************************/
/*
 File:   Sound
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/06/03
 
The sound class is resposible for playing sound effects.  For now only short 
 sound clips sould be played.  Background music should be no more than 30secs
 and looped.
 */
/******************************************************************************/
#ifndef SOUND_H
#define SOUND_H

#import <Foundation/Foundation.h>


#import <OpenAl/al.h>
#import <OpenAl/alc.h>
#include <AudioToolbox/AudioToolbox.h>

@interface Sound : NSObject

-(void)loadSoundEffect:(NSString*)fileName;
-(void)playSound

@end


#endif /* SOUND_H */
