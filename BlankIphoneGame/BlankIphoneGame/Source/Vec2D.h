/******************************************************************************/
/*
 File:   Vec2D.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to manipulate the Vec2D class.
 */
/******************************************************************************/
#ifndef Vec2D_h
#define Vec2D_h

namespace Math
{
  /*! A 2D vector for a 2D game, use a separate variable for Z-Order. */
  struct Vec2D
  {
    float x;/*!< The x coordinate of the vector*/
    float y;/*!< The y coordinate of the vector*/
  };
  
  void Vec2DSet(Vec2D& result, float x, float y);
  void Vec2DCopy(Vec2D& result, const Vec2D& toCopy);
  
  void Vec2DNegate(Vec2D& result, const Vec2D& toNegate);
  void Vec2DAdd(Vec2D& result, const Vec2D& vec1, const Vec2D& Vec2D);
  void Vec2DSub(Vec2D& result,const Vec2D& vec1,const Vec2D& Vec2D);
  void Vec2DScale(Vec2D& result, const Vec2D& toScale, float scale);
  
  void Vec2DNormalize(Vec2D& result, const Vec2D& toNormalize);
  void Vec2DProject(Vec2D& result, const Vec2D& vec1, const Vec2D& Vec2D);
  void Vec2DPerpProject(Vec2D& result,const Vec2D& vec1,const Vec2D& Vec2D);
  void Vec2DLerp(Vec2D& result, const Vec2D& vec1, const Vec2D& Vec2D,
                float time);
  float Vec2DCrossZ(const Vec2D& vec1, const Vec2D& Vec2D);
  float Vec2DDot(const Vec2D& vec1, const Vec2D& Vec2D);
  /*Get the Length or length squared of a vector*/
  float Vec2DLength(const Vec2D& vec);
  float Vec2DLengthSquared(const Vec2D& vec);
  /*Get the Distance or distance squared between tw0 points.*/
  float Vec2DDistance(const Vec2D& vec1, const Vec2D& Vec2D);
  float Vec2DDistanceSquared(const Vec2D& vec1, const Vec2D& Vec2D);
  /*Use these to test*/
  bool Vec2DEqual(const Vec2D& vec1, const Vec2D& Vec2D);
  bool Vec2DNotEqual(const Vec2D& vec1, const Vec2D& Vec2D);
  bool Vec2DIsZero(const Vec2D& vec);
  
}//end namespace Math

#endif /* Vec2D_h */
