/******************************************************************************/
/*
 File:   Mtx44.mm
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains implementation for my 4x4 matrix class functions.
 */
/******************************************************************************/
#include "Mtx44.h"
#include "GameMath.h"
#include "Vec2D.h"
#include <string.h>
#include <math.h>

/******************************************************************************/
/*!
 Sets all of the values to zero.
 
 \param result
 The Mtx44 to store the result in.
 */
/******************************************************************************/
void Mtx44MakeZero( Mtx44* result )
{
  memset(result, 0, sizeof(*result));
}
/******************************************************************************/
/*!
 Sets a Mtx44 to the identity matrix.
 
 \param result
 The Mtx44 to store the result in.
 */
/******************************************************************************/
void Mtx44MakeIdentity( Mtx44* result )
{
  memset(result, 0, sizeof(*result));
  result->m[0][0] = 1.0f;
  result->m[1][1] = 1.0f;
  result->m[2][2] = 1.0f;
  result->m[3][3] = 1.0f;
}
/******************************************************************************/
/*!
 Copies the values of one matrix into another.
 
 \param result
 The Mtx44 to store the result in.
 
 \param pToCopy
 The Mtx44 to copy.
 */
/******************************************************************************/
void Mtx44Copy( Mtx44* result, const Mtx44* toCopy )
{
  memcpy(result, toCopy, sizeof(*toCopy));
}
/******************************************************************************/
/*!
 Multiplies two Matrices together and store the result in result.
 
 \attention
 result should NOT be the same pointer as first or second. The values will be 
 changed
 
 \param result
 The Mtx44 to store the result in.
 
 \param first
 The Mtx44 on the left side.
 
 \param second
 The Mtx44 on the right side.
 */
/******************************************************************************/
void Mtx44Mult( Mtx44* result, const Mtx44* first, const Mtx44* second )
{
  result->m[0][0] =
  first->m[0][0] * second->m[0][0] +
  first->m[0][1] * second->m[1][0] +
  first->m[0][2] * second->m[2][0] +
  first->m[0][3] * second->m[3][0];
  
  result->m[1][0] =
  first->m[1][0] * second->m[0][0] +
  first->m[1][1] * second->m[1][0] +
  first->m[1][2] * second->m[2][0] +
  first->m[1][3] * second->m[3][0];
  
  result->m[2][0] =
  first->m[2][0] * second->m[0][0] +
  first->m[2][1] * second->m[1][0] +
  first->m[2][2] * second->m[2][0] +
  first->m[2][3] * second->m[3][0];
  
  result->m[3][0] =
  first->m[3][0] * second->m[0][0] +
  first->m[3][1] * second->m[1][0] +
  first->m[3][2] * second->m[2][0] +
  first->m[3][3] * second->m[3][0];
  
  /*************************************************************************/
  result->m[0][1] =
  first->m[0][0] * second->m[0][1] +
  first->m[0][1] * second->m[1][1] +
  first->m[0][2] * second->m[2][1] +
  first->m[0][3] * second->m[3][1];
  
  result->m[1][1] =
  first->m[1][0] * second->m[0][1] +
  first->m[1][1] * second->m[1][1] +
  first->m[1][2] * second->m[2][1] +
  first->m[1][3] * second->m[3][1];
  
  result->m[2][1] =
  first->m[2][0] * second->m[0][1] +
  first->m[2][1] * second->m[1][1] +
  first->m[2][2] * second->m[2][1] +
  first->m[2][3] * second->m[3][1];
  
  result->m[3][1] =
  first->m[3][0] * second->m[0][1] +
  first->m[3][1] * second->m[1][1] +
  first->m[3][2] * second->m[2][1] +
  first->m[3][3] * second->m[3][1];
  
  /*************************************************************************/
  result->m[0][2] =
  first->m[0][0] * second->m[0][2] +
  first->m[0][1] * second->m[1][2] +
  first->m[0][2] * second->m[2][2] +
  first->m[0][3] * second->m[3][2];
  
  result->m[1][2] =
  first->m[1][0] * second->m[0][2] +
  first->m[1][1] * second->m[1][2] +
  first->m[1][2] * second->m[2][2] +
  first->m[1][3] * second->m[3][2];
  
  result->m[2][2] =
  first->m[2][0] * second->m[0][2] +
  first->m[2][1] * second->m[1][2] +
  first->m[2][2] * second->m[2][2] +
  first->m[2][3] * second->m[3][2];
  
  result->m[3][2] =
  first->m[3][0] * second->m[0][2] +
  first->m[3][1] * second->m[1][2] +
  first->m[3][2] * second->m[2][2] +
  first->m[3][3] * second->m[3][2];
  
  /*************************************************************************/
  result->m[0][3] =
  first->m[0][0] * second->m[0][3] +
  first->m[0][1] * second->m[1][3] +
  first->m[0][2] * second->m[2][3] +
  first->m[0][3] * second->m[3][3];
  
  result->m[1][3] =
  first->m[1][0] * second->m[0][3] +
  first->m[1][1] * second->m[1][3] +
  first->m[1][2] * second->m[2][3] +
  first->m[1][3] * second->m[3][3];
  
  result->m[2][3] =
  first->m[2][0] * second->m[0][3] +
  first->m[2][1] * second->m[1][3] +
  first->m[2][2] * second->m[2][3] +
  first->m[2][3] * second->m[3][3];
  
  result->m[3][3] =
  first->m[3][0] * second->m[0][3] +
  first->m[3][1] * second->m[1][3] +
  first->m[3][2] * second->m[2][3] +
  first->m[3][3] * second->m[3][3];
}
/******************************************************************************/
/*!
 Creates 4x4 matrix that represents a translation of the x and y axis. Z should
 used only for zOrder.
 
 \param result
 The Mtx44 to store the result in.
 
 \param transX
 The x position in the world.
 
 \param transY
 The y position in the world.
 
 \param zOrder
 The zOrder of the object.  This should be small, such as between 0 and 1.
 */
/******************************************************************************/
void Mtx44MakeTranslate(Mtx44* result, float transX,float transY,float zOrder)
{
  Mtx44MakeIdentity(result);
  result->m[3][0] = transX;
  result->m[3][1] = transY;
  result->m[3][2] = zOrder;
}
/******************************************************************************/
/*!
 Creates 4x4 matrix that represents a scale of the x and y axis.
 
 \param result
 The Mtx44 to store the result in.
 
 
 \param scaleX
 The scale in the x direction.
 
 \param scaleY
 The scale in the y direction.
 */
/******************************************************************************/
void Mtx44MakeScale( Mtx44* result, float scaleX, float scaleY )
{
  memset(result, 0, sizeof(*result));
  result->m[0][0] = scaleX;
  result->m[1][1] = scaleY;
  result->m[2][2] = result->m[3][3] = 1.0f;
}
/******************************************************************************/
/*!
 Creates a 4x4 Matrix that represents a Rotation about the z axis.  The angle
 is specified in radians.
 
 \param result
 The Mtx44 to store the matrix in.
 
 \param radians
 The angle in radians of the rotation about the z axis.
 */
/******************************************************************************/
void Mtx44MakeRotateZ( Mtx44* result, float radians )
{
  float sinAngle = sinf(radians);
  float cosAngle = cosf(radians);
  
  memset(result, 0, sizeof(*result));
  result->m[0][0] = result->m[1][1] = cosAngle;
  result->m[1][0] = -sinAngle;
  result->m[0][1] =  sinAngle;
  result->m[2][2] = result->m[3][3] = 1.f;
}
/******************************************************************************/
/*!
 Creates a 4x4 Matrix that represents a scale rotation and translation of the
 given values multiplied in the correct order.
 
 \param result
 The Mtx44 to store the transform in.
 
 \param scaleX
 The scale in the x direction.
 
 \param scaleY
 The scale in the y direction;
 
 \param radians
 The rotation of the axis specified in radians.
 
 \param transX
 The x position in the world.
 
 \param transY
 The y position in the world.
 
 \param zOrder
 The zOrder of the object.  This should be small, such as between 0 and 1.
 */
/******************************************************************************/
void Mtx44MakeTransform(Mtx44* result, float scaleX, float scaleY,
                        float radians,
                        float transX, float transY,
                        float zOrder)
{
  float sinAngle = sinf(radians);
  float cosAngle = cosf(radians);
  
  /*Set the first ROW*/
  result->m[0][0] = scaleX * cosAngle;
  result->m[0][1] = scaleY * sinAngle;
  result->m[0][2] = 0.f;
  result->m[0][3] = 0.f;
  
  /*Set the second ROW*/
  result->m[1][0] = scaleX * -sinAngle;
  result->m[1][1] = scaleY * cosAngle;
  result->m[1][2] = 0.f;
  result->m[1][3] = 0.f;
  
  /*Set the third ROW*/
  result->m[2][0] = 0.f;
  result->m[2][1] = 0.f;
  result->m[2][2] = 1.0f;
  result->m[2][3] = 0.f;
  
  /*Set the Fourth ROW*/
  result->m[3][0] = transX;
  result->m[3][1] = transY;
  result->m[3][2] = zOrder;
  result->m[3][3] = 1.0f;
}
/******************************************************************************/
/*!
 Creates a Perspective matrix from an angle in degrees, aspect ration and near,
 far plane.
 
 \param result
 The matrix to set.
 
 \param fovDegree
 The field of view in degrees.
 
 \param aspect
 The Aspect ratio of the screen.
 
 \param near
 The distance of the near plane
 
 \param far
 The distance of the far plane
 
 */
/******************************************************************************/
void Mtx44MakePerspective(Mtx44* result, float fovDegree, float aspect, float near, float far)
{
  float scale  = tan(DEG_TO_RAD * (fovDegree * .5f)) * near;
  float right  = aspect * scale;
  float left   = -right;
  float top    = scale;
  float bottom = -top;
  
  result->m[0][0] = 2 * near / (right - left);
  result->m[0][1] = 0;
  result->m[0][2] = 0;
  result->m[0][3] = 0;
  
  result->m[1][0] = 0;
  result->m[1][1] = 2 * near / (top - bottom);
  result->m[1][2] = 0;
  result->m[1][3] = 0;
  
  result->m[2][0] = (right + left) / (right - left);
  result->m[2][1] = (top + bottom) / (top - bottom);
  result->m[2][2] = -(far + near) / (far - near);
  result->m[2][3] = -1;
  
  result->m[3][0] = 0;
  result->m[3][1] = 0;
  result->m[3][2] = -2 * far * near / (far - near);
  result->m[3][3] = 0;
  
}
/******************************************************************************/
/*!
 Creates an Orthographic projection matrix from given parameters.
 
 \param result
 The matrix to set.
 
 \param left
 The left edge of my projection
 
 \param right
 The right edge of my projection
 
 \param top
 The top edge of my projection
 
 \param bottom
 The bottom edge of my projection
 
 \param near
 The distance of the near plane
 
 \param far
 The distance of the far plane
 
 */
/******************************************************************************/
void Mtx44MakeOrtho(Mtx44* result, float left, float right, float top, float bottom, float near, float far)
{
  //row 1
  result->m[0][0] = 2 / (right - left);
  result->m[0][1] = 0;
  result->m[0][2] = 0;
  result->m[0][3] = 0;
  
  result->m[1][0] = 0;
  result->m[1][1] = 2.f / (top - bottom);
  result->m[1][2] = 0;
  result->m[1][3] = 0;
  
  result->m[2][0] = 0;
  result->m[2][1] = 0;
  result->m[2][2] = -2.f / (far - near);
  result->m[2][3] = 0;
  
  result->m[3][0] = -(right + left) / (right - left);
  result->m[3][1] = -(top + bottom) / (top - bottom);
  result->m[3][2] = -(far + near) / (far - near);
  result->m[3][3] = 1;
}
/******************************************************************************/
/*!
 Creates an view matrix from given parameters.  Since this is a simple 2D engine
 I make some assumptions: 
 
 I am always looking perpendicular to the xy plane.
 I never need to rotate the camera.
 
 If I need a better camera, I can improve this funtion in the future.
 
 \param result
 The matrix to set.
 
 \param camPos
 The
 
 \param right
 The right edge of my projection
 
 \param top
 The top edge of my projection
 
 \param bottom
 The bottom edge of my projection
 
 \param near
 The distance of the near plane
 
 \param far
 The distance of the far plane
 
 */
/******************************************************************************/
void Mtx44MakeView(Mtx44* result, const Vec2* camPos,float camDistance, const Vec2* up)
{
  //This is what the 3D code should look like.
  
  //vec3 zaxis = normal(eye - target);    // The "forward" vector.
  //vec3 xaxis = normal(cross(up, zaxis));// The "right" vector.
  //vec3 yaxis = cross(zaxis, xaxis);     // The "up" vector.
  
  //Create a 4x4 view matrix from the right, up, forward and eye position vectors
  //(      xaxis.x,            yaxis.x,            zaxis.x,       0 ),
  //(      xaxis.y,            yaxis.y,            zaxis.y,       0 ),
  //(      xaxis.z,            yaxis.z,            zaxis.z,       0 ),
  //(-dot( xaxis, eye ), -dot( yaxis, eye ), -dot( zaxis, eye ),  1 )
  
  //Since this is a 2D only game, I can make some assumptions
  
  result->m[0][0] = up->y;//1, this stops the compiler warning of unused up;
  result->m[0][1] = 0;
  result->m[0][2] = 0;
  result->m[0][3] = 0;
  
  result->m[1][0] = 0;
  result->m[1][1] = 1;
  result->m[1][2] = 0;
  result->m[1][3] = 0;
  
  result->m[2][0] = 0;
  result->m[2][1] = 0;
  result->m[2][2] = 1;
  result->m[2][3] = 0;
  
  result->m[3][0] = -camPos->x;
  result->m[3][1] = -camPos->y;
  result->m[3][2] = -camDistance;
  result->m[3][3] = 1;
}
/******************************************************************************/
/*!
 Tests if two matrix 4x4s are equal within an epsilon value.
 
 \param pMtx1
 A pointer to the first matrix
 
 \param pMtx2
 A pointer to the second matrix
 
 \return
 True if the matrices are the same, false otherwise.
 */
/******************************************************************************/
int Mtx44Equal(const Mtx44* mtx1, const Mtx44* mtx2)
{
  int x,y;
  for(y = 0; y < MTX44_ROWS; ++y)
  {
    for(x = 0; x < MTX44_COLS; ++x)
    {
      if(!FloatIsEqual(mtx1->m[y][x], mtx2->m[y][x]))
        return 0;
    }
  }
  return 1;
}
