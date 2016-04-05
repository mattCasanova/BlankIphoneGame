/******************************************************************************/
/*
 File:   Mtx44.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains definitions for my 4x4 matrix class.
 */
/******************************************************************************/
#ifndef Mtx44_h
#define Mtx44_h

#include "Vec2D.h"

namespace Math
{
  /*! A 4D Matrix for a 2D game, z is used for Z-order.
   \verbatim
   |Xx Xy Xz 0 |
   |Yx Yy Yz 0 |
   |Zx Zy Zz 0 |
   |Tx Ty Tz 1 |
   \endverbatim
   */
  const int ROWS   = 4;/*! The number of rows in the matrix*/
  const int COLS   = 4;/*! The number of columns in the matrix*/
  struct Mtx44
  {
    float m[ROWS][COLS];/*!< Array of 16 floats to represent a 4x4 matrix*/
  };
  
  void Mtx44MakeZero(Mtx44& result);
  void Mtx44MakeIdentity(Mtx44& result);
  void Mtx44Copy(Mtx44& result, const Mtx44& pToCopy);
  
  void Mtx44Mult(Mtx44& result, const Mtx44& first, const Mtx44& second);
  void Mtx44MakeTranslate(Mtx44& result,
                          float transX, float transY, float zOrder);
  void Mtx44MakeScale(Mtx44& result, float scaleX, float scaleY);
  void Mtx44MakeRotateZ(Mtx44& result, float radians);
  
  void Mtx44MakeTransform(Mtx44& result, float scaleX, float scaleY,
                          float radians,
                          float transX, float transY,
                          float zOrder);
  void Mtx44MakePerspective(Mtx44& result, float fovDegree, float aspect,
                            float nearPlane, float farPlane);
  void Mtx44MakeOrtho(Mtx44& result, float left, float right, float top,
                      float bottom, float nearPlane, float farPlane);
  void Mtx44MakeView(Mtx44& result, const Vec2D& cameraPos,float cameraDistance,
                     const Vec2D& up);
  bool Mtx44Equal(const Mtx44& pMtx1, const Mtx44& pMtx2);

}//end namespace Math

#endif /* Mtx44_hpp */
