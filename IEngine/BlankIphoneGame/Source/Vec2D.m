/******************************************************************************/
/*
 File:   Vec2D.cpp
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to manipulate the Vec2 class.
 */
/******************************************************************************/
#include "Vec2D.h"
#include "GameMath.h"
#include <math.h>
#include <string.h>//memcopy

/******************************************************************************/
/*!
 Sets the values of the vector to the given values.
 
 \param result
 A pointer to a vector to set.
 
 \param x
 The x value to copy.
 
 \param y
 The y value to copy.
 */
/******************************************************************************/
void Vec2Set( Vec2* result, float x, float y)
{
  result->x = x;
  result->y = y;
}
/******************************************************************************/
/*!
 Copies one Vec2 to another
 
 \param result
 A pointer to a vector that will be set.
 
 \param pToCopy
 A pointer to a vector to copy
 */
/******************************************************************************/
void Vec2Copy( Vec2* result, const Vec2* toCopy )
{
  memcpy(&result, &toCopy, sizeof(toCopy));
}
/******************************************************************************/
/*!
 Negates (changes the sign of) of the x, y  of the Vec2. It is ok
 to have both pointers be the same object.
 
 \param result
 To location to store the result in.
 
 \param pToNegate
 The vector or point to Negate.
 */
/******************************************************************************/
void Vec2Negate( Vec2* result, const Vec2* toNegate )
{
  result->x = toNegate->x * -1.f;
  result->y = toNegate->y * -1.f;
}
/******************************************************************************/
/*!
 This Adds x, y of the two vectors together.
 
 \param result
 The resulting vector or point.
 
 \param vec1
 The first vector or point to add.
 
 \param vec2
 The second vector or point to add.
 */
/******************************************************************************/
void Vec2Add( Vec2* result, const Vec2* vec1, const Vec2* vec2 )
{
  result->x = vec1->x + vec2->x;
  result->y = vec1->y + vec2->y;
}
/******************************************************************************/
/*!
 This subtracts x, y of the two vectors/points together. This will subtract
 the second from the first:
 result = first - second;
 
 \param result
 The location to store the result in.
 
 \param vec1
 The Vec2 to subtract from.
 
 \param vec2
 The Vec2 to subtract.
 */
/******************************************************************************/
void Vec2Sub( Vec2* result,const Vec2* vec1,const Vec2* vec2 )
{
  result->x = vec1->x - vec2->x;
  result->y = vec1->y - vec2->y;
}
/******************************************************************************/
/*!
 This scales the x, y of a vector by a specified value.
 
 \param result
 The location to store the result in.
 
 \param pToScale
 The Vec2 to scale.
 
 \param scale
 The value to scale by.
 */
/******************************************************************************/
void Vec2Scale( Vec2* result, const Vec2* toScale, float scale )
{
  result->x = toScale->x * scale;
  result->y = toScale->y * scale;
}
/******************************************************************************/
/*!
 Calculates the z value of the cross product between these two vectors.
 
 \param vec1
 The first Vec2 to cross.
 
 \param vec2
 The second Vec2 to cross.
 
 \return
 The z value of the cross product between the two vectors.
 */
/******************************************************************************/
float Vec2CrossZ( const Vec2* vec1, const Vec2* vec2 )
{
  return (vec1->x * vec2->y) - (vec2->x * vec1->y);
}
/******************************************************************************/
/*!
 Normalized a vector.  It is safe if both pointers point to the same object.
 
 \attention
 This function will crash if you normalize the zero vector.
 
 \param result
 A pointer to a vector to store the result.
 
 \param pToNormalize
 A pointer to a vector to Normalize.
 
 */
/******************************************************************************/
void Vec2Normalize( Vec2* result, const Vec2* toNormalize )
{
  float length = Vec2Length(toNormalize);
  
  //DEBUG_ASSERT(!FloatIsEqual(length, 0.f),
  //"Normalizing the zero vector");
  
  result->x = toNormalize->x/length;
  result->y = toNormalize->y/length;
}
/******************************************************************************/
/*!
 Calculates the projection vector of vec1 onto Vec2.
 
 \param result
 A pointer to a vector to store the result.
 
 
 \param vec1
 The vector you are projecting.
 
 \param vec2
 The vector you are projecting onto.
 */
/******************************************************************************/
void Vec2Project( Vec2* result, const Vec2* vec1, const Vec2* vec2 )
{
  /*Projection is (v.w)/(w.w)*w */
  
  /*Get the dot product*/
  float dotProduct = Vec2Dot(vec1, vec2);
  /*Get the length squared*/
  float lengthSquared = Vec2LengthSquared(vec2);
  
  //DEBUG_ASSERT(!FloatIsEqual(lengthSquared, 0.0f),
  // "Trying to Project onto the zero vector");
  
  /*Scale the vector;*/
  Vec2Scale(result, vec2, (dotProduct/lengthSquared));
}
/******************************************************************************/
/*!
 Calculates the perpendicular projection vector of first onto second.
 
 \attention
 This vector plus Project(first, second), will result in first.
 
 \param result
 A pointer to a vector to store the result.
 
 \param vec1
 The vector you are projecting.
 
 \param vec2
 The vector you are projecting onto.
 */
/******************************************************************************/
void Vec2PerpProject( Vec2* result,const Vec2* vec1,const Vec2* vec2 )
{
  /*Perpendictual Projection is v -(v.w)/(w.w)*w */
  Vec2 projection;
  Vec2Project(&projection, vec1, vec2);
  Vec2Sub(result, vec1, &projection);
}
/******************************************************************************/
/*!
 Calculates a linear interpolation between to vectors/points.
 
 \param result
 A pointer to a vector to store the result.
 
 \param vec1
 The first vector.  A time of 0 will give you this vector as a result.
 
 \param vec2
 The first vector.  A time of 1 will give you this vector as a result.
 
 \param time
 The interpolation time.  Doesn't have to be between 0 and 1.
 */
/******************************************************************************/
void Vec2Lerp( Vec2* result, const Vec2* vec1, const Vec2* vec2, float time )
{
  Vec2 difference;
  
  Vec2Sub(&difference, vec2, vec1);
  result->x = vec1->x + difference.x * time;
  result->y = vec1->y + difference.y * time;
}
/******************************************************************************/
/*!
 Calculates the Dot Product of two vectors.
 
 \param vec1
 A pointer to the first vector.
 
 \param vec2
 A pointer to the second vector.
 
 \return
 The Dot product of the two vectors.
 */
/******************************************************************************/
float Vec2Dot( const Vec2* vec1, const Vec2* vec2 )
{
  return (vec1->x * vec2->x) + (vec1->y * vec2->y);
}
/******************************************************************************/
/*!
 Returns the length of the vector.
 
 \param vec
 A pointer to the vector to check.
 
 \return
 The length of the vector.
 */
/******************************************************************************/
float Vec2Length( const Vec2* vec )
{
  /*Use sqrt to get length*/
  return sqrtf(vec->x*vec->x + vec->y*vec->y);
}
/******************************************************************************/
/*!
 Returns the length of the vector squared.
 
 \param vec
 A pointer to the vector to check.
 
 \return
 The length of the vector squared.
 */
/******************************************************************************/
float Vec2LengthSquared( const Vec2* vec )
{
  /*Do dot product with itself to get length squared.*/
  return (vec->x * vec->x) + (vec->y * vec->y);
}
/******************************************************************************/
/*!
 Returns the distance between two points.
 
 \attention
 The function is meant to be used with points, not vectors.
 
 \param vec1
 A pointer to the first point.
 
 \param vec2
 A pointer to the second point.
 
 \return
 The distance between to points.
 */
/******************************************************************************/
float Vec2Distance( const Vec2* vec1, const Vec2* vec2 )
{
  /*Get the Square root of the squared version.*/
  return sqrtf((vec1->x * vec2->x) + (vec1->y * vec2->y));
}
/******************************************************************************/
/*!
 Returns the squared distance between two points.
 
 \attention
 The function is meant to be used with points, not vectors.
 
 \param vec1
 A pointer to the first point.
 
 \param vec2
 A pointer to the second point.
 
 \return
 The squared distance between to points.
 */
/******************************************************************************/
float Vec2DistanceSquared( const Vec2* vec1, const Vec2* vec2 )
{
  Vec2 vec;
  
  /*Get the vector between them*/
  Vec2Sub(&vec, vec2, vec1);
  /*Get the length of that vector squared*/
  return Vec2LengthSquared(&vec);
}
/******************************************************************************/
/*!
 Tests if two Vec2 are equal.
 
 \param vec1
 A pointer to the first Vec2 to test.
 
 \param vec2
 A pointer to the second Vec2 to test.
 
 \return
 True if the Vec2 are the same, false otherwise.
 */
/******************************************************************************/
int Vec2Equal( const Vec2* vec1, const Vec2* vec2 )
{
  /*Test if the difference is really close to zero*/
  return (fabsf(vec1->x-vec2->x) < EPSILON && fabsf(vec1->y-vec2->y) < EPSILON );
  
}
/******************************************************************************/
/*!
 Tests if two Vec2 are not equal.
 
 \param vec1
 A pointer to the first Vec2 to test.
 
 \param vec2
 A pointer to the second Vec2 to test.
 
 \return
 True if the Vec2 are not the same, false otherwise.
 */
/******************************************************************************/
int Vec2NotEqual( const Vec2* vec1, const Vec2* vec2 )
{
  /*Just get the opposite of Equal*/
  return !Vec2Equal(vec1, vec2);
}
/******************************************************************************/
/*!
 Tests if the x, y members are zero
 
 \param vec
 A pointer to the Vec2 to test.
 
 \return
 Returns true if the x, y are zero. False otherwise
 */
/******************************************************************************/
int Vec2IsZero( const Vec2* vec )
{
  /*Test if they are really close to zero*/
  return (fabsf(vec->x) < EPSILON && fabsf(vec->y) < EPSILON);
}

