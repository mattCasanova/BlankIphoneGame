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


/*!The smallest value between two floats*/
static const float EPSILON    = 0.00001f;
/*!The value of PI*/
static const float PI         = 3.14159265358979f;
/*!The Value of PI/2*/
static const float HALF_PI    = 1.5707963267949f;
/*!The value of 2PI*/
static const float TWO_PI     = 6.28318530717959f;
/*!The conversion factor of degree to Radian*/
static const float DEG_TO_RAD = 0.01745329251994f;
/*!The conversion factor of radian to degree*/
static const float RAD_TO_DEG = 57.29577951308233f;
  

float Clamp(float x, float low, float high);
float Wrap(float x, float low, float high);
float Min(float x, float y);
float Max(float x, float y);
int   InRange(float x, float low, float high);
int   FloatIsEqual(float x, float y);
int   IsPowerOf2(int x);
int   GetNextPowerOf2(int x);

#endif /* GameMath_h */
