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

#include <map>//for textures

class MyGraphics
{
public:
  MyGraphics(void);
  ~MyGraphics(void);
  
  void Init(EAGLContext* pContext, float width, float height);
  void Shutdown(void);
  
  void StartDraw(void);/*This should be called once before drawing all objects*/
  void Draw(const Math::Mtx44& worldMatrix);
  void EndDraw(void);/*This should be called once after drawing all objects*/
  
  
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
  bool CompileShader(GLuint* shader, GLenum type, NSString* file);
  bool LinkProgram(GLuint prog);
  bool ValidateProgram(GLuint prog);
  
  typedef std::map<NSString*, NSString*> TextureMap;
  
  Math::MtxStack m_stack;     //to pass one matrix to shader
  TextureMap m_textures;      //map textures to file names
  float m_bgRed;              //red component of background
  float m_bgGreen;            //green component of background
  float m_bgBlue;             //blue componment of background
  float m_width;              //screen width
  float m_height;             //screen height
  
  
  // Uniform index.
  enum
  {
    UNIFORM_MVP_MATRIX,
    UNIFORM_TEX_SAMPLER,
    UNIFORM_TEX_COORDS,
    UNIFORM_COLOR,
    NUM_UNIFORMS
  };
  GLint uniforms[NUM_UNIFORMS];
  
  //Attributes
  GLuint m_posAttrib;
  GLuint m_texAttrib;
  
  GLKMatrix4   m_MVPMatrix;      //model view projection matrix
  GLuint       m_vertexArray;    //saved opengl options
  GLuint       m_vertexBuffer;   //Textured quad mesh
  GLuint       m_program;        //the shader program
  EAGLContext* m_pContext;
  
};


#endif //end GRAPHICS_H
