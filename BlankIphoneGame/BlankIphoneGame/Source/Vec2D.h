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
  struct Vec2
  {
    float x;/*!< The x coordinate of the vector*/
    float y;/*!< The y coordinate of the vector*/
  };
  
  void Vec2Set(Vec2& result, float x, float y);
  void Vec2Copy(Vec2& result, const Vec2& toCopy);
  
  void Vec2Negate(Vec2& result, const Vec2& toNegate);
  void Vec2Add(Vec2& result, const Vec2& vec1, const Vec2& vec2);
  void Vec2Sub(Vec2& result,const Vec2& vec1,const Vec2& vec2);
  void Vec2Scale(Vec2& result, const Vec2& toScale, float scale);
  
  void Vec2Normalize(Vec2& result, const Vec2& toNormalize);
  void Vec2Project(Vec2& result, const Vec2& vec1, const Vec2& vec2);
  void Vec2PerpProject(Vec2& result,const Vec2& vec1,const Vec2& vec2);
  void Vec2Lerp(Vec2& result, const Vec2& vec1, const Vec2& vec2,
                float time);
  float Vec2CrossZ(const Vec2& vec1, const Vec2& vec2);
  float Vec2Dot(const Vec2& vec1, const Vec2& vec2);
  /*Get the Length or length squared of a vector*/
  float Vec2Length(const Vec2& vec);
  float Vec2LengthSquared(const Vec2& vec);
  /*Get the Distance or distance squared between tw0 points.*/
  float Vec2Distance(const Vec2& vec1, const Vec2& vec2);
  float Vec2DistanceSquared(const Vec2& vec1, const Vec2& vec2);
  /*Use these to test*/
  bool Vec2Equal(const Vec2& vec1, const Vec2& vec2);
  bool Vec2NotEqual(const Vec2& vec1, const Vec2& vec2);
  bool Vec2IsZero(const Vec2& vec);
  
}//end namespace Math

#endif /* Vec2D_h */
