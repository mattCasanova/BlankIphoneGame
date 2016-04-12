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

namespace
{
#define BUFFER_OFFSET(i) ((char *)NULL + (i))
  
  
// Attribute index.
enum
{
  ATTRIB_VERTEX,
  NUM_ATTRIBUTES
};
  
  
}//end namespace

MyGraphics::MyGraphics(void)
{
}
MyGraphics::~MyGraphics(void)
{

}
void MyGraphics::InitOpenGL(void)
{
  //Set drawing state of game
  
  glDisable(GL_DEPTH_TEST);
  /*Enable textures and texture blending*/
  glEnable(GL_TEXTURE_2D);
  glEnable( GL_BLEND );
  glActiveTexture(GL_TEXTURE0);
  glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
  
  //Create vertex array (to save and load my open gl state)
  glGenVertexArraysOES(1, &m_vertexArray);
  glBindVertexArrayOES(m_vertexArray);
  
  //Make my vertex buffer
  GLfloat mesh[36] =
  {
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
  
  glBindVertexArrayOES(0);
  
  glUseProgram(m_program);
}
void MyGraphics::Init(EAGLContext* pContext, float width, float height)
{
  //Set class variables
  m_width    = width;
  m_height   = height;
  
  //Set 
  SetBackGroundColor(1, 1, 1);
  SetTextureColor(1, 1, 1, 1);
  SetTextureCoords(1, 1, 0, 0);
  
  //Update context
  m_pContext = pContext;
  [EAGLContext setCurrentContext:m_pContext];
  
  LoadShaders();
  InitOpenGL();
  
  //Set up matrix stack
  m_stack.Clear();
  Math::Mtx44 proj;
  Math::Mtx44MakeOrtho(proj, 0, m_width, 0, m_height, 1, -1);
  m_stack.Load(proj);
}
void MyGraphics::Shutdown(void)
{
  [EAGLContext setCurrentContext:m_pContext];
  
  glDeleteBuffers(1, &m_vertexBuffer);
  glDeleteVertexArraysOES(1, &m_vertexArray);
  
  
  if (m_program) {
    glDeleteProgram(m_program);
    m_program = 0;
  }
}

bool MyGraphics::LoadShaders(void)
{
  GLuint vertShader, fragShader;
  NSString *vertShaderPathname, *fragShaderPathname;
  
  // Create shader program.
  m_program = glCreateProgram();
  
  // Create and compile vertex shader.
  vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
  if (!CompileShader(&vertShader, GL_VERTEX_SHADER, vertShaderPathname))
  {
    NSLog(@"Failed to compile vertex shader");
    return false;
  }
  
  // Create and compile fragment shader.
  fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
  if (!CompileShader(&fragShader, GL_FRAGMENT_SHADER, fragShaderPathname))
  {
    NSLog(@"Failed to compile fragment shader");
    return false;
  }
  
  glAttachShader(m_program, vertShader);// Attach vertex shader to program.
  glAttachShader(m_program, fragShader);// Attach fragment shader to program.
  
  // Bind attribute locations.
  // This needs to be done prior to linking.
  glBindAttribLocation(m_program, GLKVertexAttribPosition, "position");
  glBindAttribLocation(m_program, GLKVertexAttribTexCoord0, "texCoord");
  
  // Link program.
  if (!LinkProgram(m_program))
  {
    NSLog(@"Failed to link program: %d", m_program);
    
    if (vertShader) {
      glDeleteShader(vertShader);
      vertShader = 0;
    }
    if (fragShader) {
      glDeleteShader(fragShader);
      fragShader = 0;
    }
    if (m_program) {
      glDeleteProgram(m_program);
      m_program = 0;
    }
    
    return false;
  }
  
  // Get uniform locations.
  uniforms[UNIFORM_MVP_MATRIX]  = glGetUniformLocation(m_program, "MVPMatrix");
  uniforms[UNIFORM_TEX_SAMPLER] = glGetUniformLocation(m_program, "sampler");
  uniforms[UNIFORM_COLOR]       = glGetUniformLocation(m_program, "color");
  uniforms[UNIFORM_TEX_COORDS]  = glGetUniformLocation(m_program, "texTrans");
  
  
  // Release vertex and fragment shaders.
  if (vertShader)
  {
    glDetachShader(m_program, vertShader);
    glDeleteShader(vertShader);
  }
  if (fragShader)
  {
    glDetachShader(m_program, fragShader);
    glDeleteShader(fragShader);
  }
  
  return true;
}
bool MyGraphics::CompileShader(GLuint* shader, GLenum type, NSString* file)
{
  GLint status;
  const GLchar *source;
  
  source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
  if (!source)
  {
    NSLog(@"Failed to load vertex shader");
    return false;
  }
  
  *shader = glCreateShader(type);
  glShaderSource(*shader, 1, &source, NULL);
  glCompileShader(*shader);
  
#if defined(DEBUG)
  GLint logLength;
  glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0)
  {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetShaderInfoLog(*shader, logLength, &logLength, log);
    NSLog(@"Shader compile log:\n%s", log);
    free(log);
  }
#endif
  
  glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
  if (status == 0)
  {
    glDeleteShader(*shader);
    return false;
  }
  
  return true;
}
bool MyGraphics::LinkProgram(GLuint prog)
{
  GLint status;
  glLinkProgram(prog);
  
#if defined(DEBUG)
  GLint logLength;
  glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0)
  {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetProgramInfoLog(prog, logLength, &logLength, log);
    NSLog(@"Program link log:\n%s", log);
    free(log);
  }
#endif
  
  glGetProgramiv(prog, GL_LINK_STATUS, &status);
  if (status == 0)
  {
    return NO;
  }
  
  return YES;
}
bool MyGraphics::ValidateProgram(GLuint prog)
{
  GLint logLength, status;
  
  glValidateProgram(prog);
  glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
  if (logLength > 0)
  {
    GLchar *log = (GLchar *)malloc(logLength);
    glGetProgramInfoLog(prog, logLength, &logLength, log);
    NSLog(@"Program validate log:\n%s", log);
    free(log);
  }
  
  glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
  if (status == 0)
  {
    return false;
  }
  
  return true;
}
void MyGraphics::StartDraw(void)
{
  glClear(GL_COLOR_BUFFER_BIT);
  glBindVertexArrayOES(m_vertexArray);
  
}
void MyGraphics::EndDraw(void)
{
  glBindVertexArrayOES(0);
}
int  MyGraphics::LoadTexture(NSString* textureName)
{
  NSString* fileName;
  
  /*if (m_usingEnglish) {
    fileName = m_englishNames[textureName];
  }
  else
    fileName = m_koreanNames[textureName];*/
  
  CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
  if (!spriteImage)
  {
    NSLog(@"Failed to load image %@", textureName);
    exit(1);
  }
  
  CFDataRef imageData;
  size_t width  = CGImageGetWidth(spriteImage);
  size_t height = CGImageGetHeight(spriteImage);
  
  imageData = CGDataProviderCopyData(CGImageGetDataProvider(spriteImage));
  GLubyte* spriteData = (GLubyte*)CFDataGetBytePtr(imageData);
  
  int texName;
  glGenTextures(1, (GLuint*)&texName);
  glBindTexture(GL_TEXTURE_2D, texName);
  
  // use linear filetring
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
  // clamp to edge
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, (GLsizei)width, (GLsizei)height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
  
  CFRelease(imageData);
  return texName;
}
void MyGraphics::UnloadTexture(int textureID)
{
  glDeleteTextures(1, (GLuint*)&textureID);
}
void MyGraphics::SetTexture(int textureID)
{
  glBindTexture(GL_TEXTURE_2D, textureID);
  glUniform1i(uniforms[UNIFORM_TEX_SAMPLER], 0);
}
void MyGraphics::SetTextureCoords(float scaleX, float scaleY,
                                  float transX, float transY)
{
  GLfloat coords[4] = {scaleX, scaleY, transX, transY};
  glUniform4fv(uniforms[UNIFORM_TEX_COORDS], 1, coords);
}
void MyGraphics::SetTextureColor(float red, float green, float blue, float alpha)
{
  GLfloat colors[4] = {red, green, blue, alpha};
  glUniform4fv(uniforms[UNIFORM_COLOR], 1, colors);
}


void MyGraphics::Draw(const Math::Mtx44& worldMatrix)
{
  m_stack.Push(worldMatrix);
  glUniformMatrix4fv(uniforms[UNIFORM_MVP_MATRIX], 1, 0, (GLfloat*)m_stack.Top().m);
  glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
  m_stack.Pop();
}

void MyGraphics::SetBackGroundColor(float red, float green, float blue)
{
  m_bgRed   = red;
  m_bgGreen = green;
  m_bgBlue = blue;
  glClearColor(m_bgRed, m_bgGreen, m_bgBlue, 1.0f);
}
