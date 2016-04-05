/******************************************************************************/
/*
 File:   GameMath.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
  This file contains math functions that are useful in a game.
*/
/******************************************************************************/
#ifndef GameMath_h
#define GameMath_h

namespace Math
{
  const float EPSILON  = 0.00001f;/*!The smallest value between two floats*/
  const float PI      = 3.1415926535897932384626433832795f;/*!The value of PI*/
  const float HALF_PI = (PI * .5f); /*!The Value of PI/2*/
  const float TWO_PI  = (PI * 2.0f);/*!The value of 2PI*/
  
  
  float RadianToDegree(float radians);
  float DegreeToRadian(float degrees);
  float Clamp(float x, float low, float high);
  float Wrap(float x, float low, float high);
  float Min(float x, float y);
  float Max(float x, float y);
  bool  InRange(float x, float low, float high);
  bool  FloatIsEqual(float x, float y);
  bool  IsPowerOf2(int x);
  int   GetNextPowerOf2(int x);
}//end namespace Math


#endif /* GameMath_h */
