/******************************************************************************/
/*
 File:   Graphics.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/010
 

 Header for basic graphics
 */
/******************************************************************************/
#ifndef GRAPHICS_H
#define GRAPHICS_H

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>
#import "MtxStack.h"
#import "Mtx44.h"

//#include <map>//for textures

@interface Graphics : NSObject

-(id)initWithContext:(EAGLContext*)context Width:(float)width Height:(float)height;
-(void)dealloc;

-(void)clearScreen;
-(void)present;
-(void)draw:(const Math::Mtx44*)world;
-(int)loadTexture:(NSString*)fileName;
-(void)unloadTexture:(int)textureID;
-(void)setTexture:(int)textureID;
-(void)setTextureScaleX:(float)sX
                 ScaleY:(float)sY
                 TransX:(float)tX
                 TransY:(float)tY;
-(void)setTextureRed:(float)red
               Green:(float)green
                Blue:(float)blue
               Alpha:(float)alpha;
-(void)setBackgroundRed:(float)red
                  Green:(float)green
                   Blue:(float)blue;
@end

/*

class Graphics
{
public:
  Graphics(EAGLContext* pContext, float width, float height);
  ~Graphics(void);
  
  void StartDraw(void);//This should be called once before drawing all objects
  void Draw(const Math::Mtx44& worldMatrix);
  void EndDraw(void);//This should be called once after drawing all objects
  
  
  int  LoadTexture(NSString* fileName);
  void UnloadTexture(int textureID);
  
  void SetTexture(int textureID);
  void SetTextureCoords(float scaleX, float scaleY,
                        float transX, float transY);
  void SetTextureColor(float red, float green, float blue, float alpha);
  void SetBackGroundColor(float red, float green, float blue);
  
private:
  void InitOpenGL(void);
  bool LoadShaders(void);
  bool CompileShader(GLuint& shader, GLenum type, NSString* file);
  bool LinkProgram(GLuint prog);
  bool ValidateProgram(GLuint prog);
  
  //typedef std::map<NSString*, NSString*> TextureMap;
  // Uniform index.
  enum
  {
    UNIFORM_MVP_MATRIX,
    UNIFORM_TEX_SAMPLER,
    UNIFORM_TEX_COORDS,
    UNIFORM_COLOR,
    NUM_UNIFORMS
  };
  
  Math::MtxStack m_stack;                 //to pass one matrix to shader
  //TextureMap     m_textures;              //map textures to file names
  EAGLContext*   m_pContext;              //OpenGL Render Context
  float          m_bgRed;                 //red component of background
  float          m_bgGreen;               //green component of background
  float          m_bgBlue;                //blue componment of background
  float          m_width;                 //game width
  float          m_height;                //game height
  GLuint         m_GLState;               //saved opengl options
  GLuint         m_vertexBuffer;          //Textured quad mesh
  GLuint         m_program;               //the shader program
  GLint          m_uniforms[NUM_UNIFORMS];//Array of shader uniforms
  
  
};*/


#endif //end GRAPHICS_H
