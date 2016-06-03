/******************************************************************************/
/*
 File:   Graphics.cpp
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/010
 
 
 Implimentation for basic graphics
 */
/******************************************************************************/
#include "Graphics.h"
#import "MtxStack.h"

//Helper macro for getting byte offset of verts
#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define DELETE_SHADER(shader) if(shader){glDeleteShader(shader);shader=0;}
#define DELETE_PROGRAM(program) if(program){glDeleteProgram(program);program=0;}

#define STACK_START_SIZE 6

static void ShaderDebugPrint(GLuint shader, NSString* header);
static void ProgDebugPrint(GLuint prog, NSString* header);
static bool GetProgramStatus(GLuint prog, GLenum type);

// Uniform index.
enum
{
  UNIFORM_MVP_MATRIX,
  UNIFORM_TEX_SAMPLER,
  UNIFORM_TEX_COORDS,
  UNIFORM_COLOR,
  NUM_UNIFORMS
};

//private data
@interface Graphics ()
{
  MtxStack*      m_stack;                 //to pass one matrix to shader
  //TextureMap     m_textures;              //map textures to file names
  float          m_bgRed;                 //red component of background
  float          m_bgGreen;               //green component of background
  float          m_bgBlue;                //blue componment of background
  Vec2           m_screenSize;            //Screen Width and Height
  GLuint         m_GLState;               //saved opengl options
  GLuint         m_vertexBuffer;          //Textured quad mesh
  GLuint         m_program;               //the shader program
  GLint          m_uniforms[NUM_UNIFORMS];//Array of shader uniforms
}
//private functions
-(void)initOpenGL;
-(BOOL)loadShaders;
-(BOOL)compileShader:(GLuint*)shader Type:(GLenum)type FileName:(NSString*)file;
-(BOOL)linkProgram:(GLuint)program;
-(BOOL)validateProgram:(GLuint)program;

//typedef std::map<NSString*, NSString*> TextureMap;



@end

@implementation Graphics

/******************************************************************************/
/*
 Contructor for graphics class.
 */
/******************************************************************************/
-(Graphics*)initWithWidth:(float)width Height:(float)height
{
  self = [super init];
  if(!self)
    return nil;
  
  //Set class variables
  m_screenSize.x = width;
  m_screenSize.y = height;
  
  [self loadShaders];
  [self initOpenGL];
  
  //Set defaults
  [self setBackgroundRed:1 Green:1 Blue:1];
  [self setTextureRed:1 Green:1 Blue:1 Alpha:1];
  [self setTextureScaleX:1 ScaleY:1 TransX:0 TransY:0];
  //Set up matrix stack
  m_stack = [[MtxStack alloc]initWithStartSize:STACK_START_SIZE];
  Mtx44 proj;
  Mtx44MakeOrtho(&proj, 0, m_screenSize.x, 0, m_screenSize.y, -1, 1);
  [m_stack load:&proj];
  
  return self;
}
/******************************************************************************/
/*
 Destructor for graphics class.
 */
/******************************************************************************/
-(void)dealloc
{
  glDeleteBuffers(1, &m_vertexBuffer);
  glDeleteVertexArraysOES(1, &m_GLState);
  DELETE_PROGRAM(m_program);
}
/******************************************************************************/
/*
   Class helper to contain all my openGL initilizations
*/
/******************************************************************************/
-(void)initOpenGL
{
  //Set drawing state of game
  glDisable(GL_DEPTH_TEST);
  /*Enable textures and texture blending*/
  glEnable(GL_TEXTURE_2D);
  glEnable( GL_BLEND );
  //glEnable(GL_CULL_FACE);
  //glCullFace(GL_CW);
  glActiveTexture(GL_TEXTURE0);
  glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
  

  
  //Create vertex array (to save and load my open gl state)
  glGenVertexArraysOES(1, &m_GLState);
  glBindVertexArrayOES(m_GLState);
  
  //Make my vertex buffer
  GLfloat mesh[36] = {
    // Data layout for each line below is:
    // positionX, positionY, positionZ, tu, tv
    -0.5f,  -0.5f, 0.0f,   0.0f, 0.0f,  //bot left
     0.5f,  -0.5f, 0.0f,   1.0f, 0.0f,  //bot right
    -0.5f,   0.5f, 0.0f,   0.0f, 1.0f,  //top left
     0.5f,   0.5f, 0.0f,   1.0f, 1.0f   //top right
    
  };

  //save mesh to vertex buffer on gfx card
  glGenBuffers(1, &m_vertexBuffer);
  glBindBuffer(GL_ARRAY_BUFFER, m_vertexBuffer);
  glBufferData(GL_ARRAY_BUFFER, sizeof(mesh), mesh, GL_STATIC_DRAW);
  
  
  float stride = 20;
  float positionCount = 3;
  float textureCoordCount = 2;
  
  //let opengl know I will be using postions in my vertex
  glEnableVertexAttribArray(GLKVertexAttribPosition);
  glVertexAttribPointer(GLKVertexAttribPosition,
                        positionCount,
                        GL_FLOAT,
                        GL_FALSE,
                        stride,
                        BUFFER_OFFSET(0));
  
  //let open gl know I will be using texture coords in my vertex
  glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
  glVertexAttribPointer(GLKVertexAttribTexCoord0,
                        textureCoordCount,
                        GL_FLOAT,
                        GL_FALSE,
                        stride,
                        BUFFER_OFFSET(3 * sizeof(GLfloat)));
  
  
  glUseProgram(m_program);
  glBindVertexArrayOES(0);
}
/******************************************************************************/
/*
 Class helper to Load my shaders
*/
/******************************************************************************/
-(BOOL)loadShaders
{
  GLuint vertShader, fragShader;
  NSString* vertShaderPathname;
  NSString* fragShaderPathname;
  BOOL result = NO;
  
  // Create shader program.
  m_program = glCreateProgram();
  
  // Create and compile vertex shader.
  vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Vertex"
                                                       ofType:@"vert"];
  result = [self compileShader:&vertShader
                          Type:GL_VERTEX_SHADER
                      FileName:vertShaderPathname];
  
  if (!result)
  {
    NSLog(@"Failed to compile vertex shader");
    return NO;
  }
  
  // Create and compile fragment shader.
  fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Fragment"
                                                       ofType:@"frag"];
  result = [self compileShader:&fragShader
                          Type:GL_FRAGMENT_SHADER
                      FileName:fragShaderPathname];
  
  if (!result)
  {
    DELETE_SHADER(vertShader);
    NSLog(@"Failed to compile fragment shader");
    return NO;
  }
  
  // Attach shaders to program.
  glAttachShader(m_program, vertShader);
  glAttachShader(m_program, fragShader);
  
  // Bind attribute locations. This needs to be done prior to linking.
  glBindAttribLocation(m_program, GLKVertexAttribPosition,  "position");
  glBindAttribLocation(m_program, GLKVertexAttribTexCoord0, "texCoord");
  
  // Link program.
  result = [self linkProgram:m_program];
  
  if (!result)
  {
    DELETE_SHADER(vertShader);
    DELETE_SHADER(fragShader);
    DELETE_PROGRAM(m_program);
    NSLog(@"Failed to link program: %d", m_program);
    return NO;
  }
  
  // Get uniform locations.
  m_uniforms[UNIFORM_MVP_MATRIX]  = glGetUniformLocation(m_program, "MVPMatrix");
  m_uniforms[UNIFORM_TEX_SAMPLER] = glGetUniformLocation(m_program, "sampler");
  m_uniforms[UNIFORM_COLOR]       = glGetUniformLocation(m_program, "color");
  m_uniforms[UNIFORM_TEX_COORDS]  = glGetUniformLocation(m_program, "texTrans");
  
  
  //After we link we can release vertex and fragment shaders.
  if (vertShader)
  {
    glDetachShader(m_program, vertShader);
    DELETE_SHADER(vertShader);
  }
  if (fragShader)
  {
    glDetachShader(m_program, fragShader);
    DELETE_SHADER(fragShader);
  }
  
  return YES;
}
/******************************************************************************/
/*
 Class helper to Load my shaders
*/
/******************************************************************************/
-(BOOL)compileShader:(GLuint*)shader Type:(GLenum)type FileName:(NSString*)file
{
  GLint status;
  const GLchar *source;
  
  //load text from shader
  source = (GLchar *)[[NSString stringWithContentsOfFile: file
                                                encoding: NSUTF8StringEncoding
                                                   error: nil] UTF8String];
  if (!source)
  {
    NSLog(@"Failed to load shader file");
    return NO;
  }
  
  *shader = glCreateShader(type);
  glShaderSource(*shader, 1, &source, NULL);
  glCompileShader(*shader);
  
#if defined(DEBUG)
  ShaderDebugPrint(*shader, @"Shader Compile Log");
#endif
  
  glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
  if (status == 0)
  {
    glDeleteShader(*shader);
    return NO;
  }
  
  return YES;
}
/******************************************************************************/
/*
 Class helper to Link my shaders
*/
/******************************************************************************/
-(BOOL)linkProgram:(GLuint)program
{
  glLinkProgram(program);
  
#if defined(DEBUG)
  ProgDebugPrint(program, @"Program Link Log");
#endif
  
  return GetProgramStatus(program, GL_LINK_STATUS);
}
/******************************************************************************/
/*

 */
/******************************************************************************/
-(BOOL)validateProgram:(GLuint)program
{
  glValidateProgram(program);
#if defined(DEBUG)
  ProgDebugPrint(program, @"Program validate Log");
#endif
  
  return GetProgramStatus(program, GL_VALIDATE_STATUS);

}
/******************************************************************************/
/*
 Must be called before any drawing is done
*/
/******************************************************************************/
-(void)clearScreen
{
  glClear(GL_COLOR_BUFFER_BIT);
  glBindVertexArrayOES(m_GLState);
  
}
/******************************************************************************/
/*
Must be called after all drawing is done
*/
/******************************************************************************/
-(void)present
{
  glBindVertexArrayOES(0);
}
/******************************************************************************/
/*
  Loads a texture from a file
*/
/******************************************************************************/
-(int)loadTexture:(NSString *)fileName
{
  //Load image from file
  CGImageRef cgImage = [UIImage imageNamed:fileName].CGImage;
  if (!cgImage)
  {
    NSLog(@"Failed to load image %@", fileName);
    exit(1);
  }
  
  GLsizei width  = (GLsizei)CGImageGetWidth(cgImage);
  GLsizei height = (GLsizei)CGImageGetHeight(cgImage);
  
  CFDataRef cfData  = CGDataProviderCopyData(CGImageGetDataProvider(cgImage));
  GLubyte* byteData = (GLubyte*)CFDataGetBytePtr(cfData);
  
  int textureID;
  glGenTextures(1, (GLuint*)&textureID);
  glBindTexture(GL_TEXTURE_2D, textureID);
  
  // use linear filetring
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_NEAREST);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_NEAREST);
  // clamp to edge
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, byteData);
  
  CFRelease(cfData);
  return textureID;
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)unloadTexture:(int)textureID
{
  glDeleteTextures(1, (GLuint*)&textureID);
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)setTexture:(int)textureID
{
  glBindTexture(GL_TEXTURE_2D, textureID);
  glUniform1i(m_uniforms[UNIFORM_TEX_SAMPLER], 0);
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)setTextureScaleX:(float)sX ScaleY:(float)sY TransX:(float)tX TransY:(float)tY
{
  GLfloat coords[4] = {sX, sY, tX, tY};
  glUniform4fv(m_uniforms[UNIFORM_TEX_COORDS], 1, coords);
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)setTextureRed:(float)red Green:(float)green Blue:(float)blue Alpha:(float)alpha
{
  GLfloat colors[4] = {red, green, blue, alpha};
  glUniform4fv(m_uniforms[UNIFORM_COLOR], 1, colors);
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)draw:(const Mtx44*)world
{
  [m_stack push: world];
  const Mtx44* top = [m_stack top];
  glUniformMatrix4fv(m_uniforms[UNIFORM_MVP_MATRIX], 1, 0, (GLfloat*)top);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  [m_stack pop];
}
/******************************************************************************/
/*
 Class helper to Load my shaders
 */
/******************************************************************************/
-(void)setBackgroundRed:(float)red Green:(float)green Blue:(float)blue
{
  m_bgRed   = red;
  m_bgGreen = green;
  m_bgBlue  = blue;
  glClearColor(m_bgRed, m_bgGreen, m_bgBlue, 1.0f);
}
/******************************************************************************/
/*
 Returns the size of the game wor
 */
/******************************************************************************/
-(const Vec2*)getScreenSize
{
  return &m_screenSize;
}
@end
//end of Graphics implementation



/******************************************************************************/
/*
 Static Helper Funcitons
 */
/******************************************************************************/
/******************************************************************************/
/*
 Helper funciton to print log info if shader doesn't load
 */
/******************************************************************************/
static void ShaderDebugPrint(GLuint shader, NSString* header)
{
  GLint logLength;
  glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0)
  {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetShaderInfoLog(shader, logLength, &logLength, log);
    NSLog(@"%@:\n%s",header, log);
    free(log);
  }
}
/******************************************************************************/
/*
 Helper funciton to print log info if program can't link or can't be
 validated
 */
/******************************************************************************/
static void ProgDebugPrint(GLuint prog, NSString* header)
{
  GLint logLength;
  glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0)
  {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetProgramInfoLog(prog, logLength, &logLength, log);
    NSLog(@"%@:\n%s", header, log);
    free(log);
  }
}
/******************************************************************************/
/*
 Helper function to get return the status of linking or validating the shader
 program
 */
/******************************************************************************/
static bool GetProgramStatus(GLuint prog, GLenum type)
{
  GLint status;
  glGetProgramiv(prog, type, &status);
  return (status == 0)? false : true;
}

