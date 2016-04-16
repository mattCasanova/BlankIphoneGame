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


const float EPSILON    = 0.00001f;          /*!The smallest value between two floats*/
const float PI         = 3.14159265358979f; /*!The value of PI*/
const float HALF_PI    = 1.5707963267949f;  /*!The Value of PI/2*/
const float TWO_PI     = 6.28318530717959f; /*!The value of 2PI*/
const float DEG_TO_RAD = 0.01745329251994f; /*!The conversion factor of degree to Radian*/
const float RAD_TO_DEG = 57.29577951308233f;/*!The conversion factor of radian to degree*/
  

float Clamp(float x, float low, float high);
float Wrap(float x, float low, float high);
float Min(float x, float y);
float Max(float x, float y);
bool  InRange(float x, float low, float high);
bool  FloatIsEqual(float x, float y);
bool  IsPowerOf2(int x);
int   GetNextPowerOf2(int x);

#endif /* GameMath_h */
