/******************************************************************************/
/*
 File:   Vec2D.cpp
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to manipulate the Vec2D class.
 */
/******************************************************************************/
#include "Vec2D.h"
#include "GameMath.h"
#include <cmath>
#include <cstring>//memcopy

namespace Math
{
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
  void Vec2DSet( Vec2D& result, float x, float y)
  {
    result.x = x;
    result.y = y;
  }
  /******************************************************************************/
  /*!
   Copies one Vec2D to another
   
   \param result
   A pointer to a vector that will be set.
   
   \param pToCopy
   A pointer to a vector to copy
   */
  /******************************************************************************/
  void Vec2DCopy( Vec2D& result, const Vec2D& toCopy )
  {
    std::memcpy(&result, &toCopy, sizeof(toCopy));
  }
  /******************************************************************************/
  /*!
   Negates (changes the sign of) of the x, y  of the Vec2D. It is ok
   to have both pointers be the same object.
   
   \param result
   To location to store the result in.
   
   \param pToNegate
   The vector or point to Negate.
   */
  /******************************************************************************/
  void Vec2DNegate( Vec2D& result, const Vec2D& toNegate )
  {
    result.x = toNegate.x * -1.f;
    result.y = toNegate.y * -1.f;
  }
  /******************************************************************************/
  /*!
   This Adds x, y of the two vectors together.
   
   \param result
   The resulting vector or point.
   
   \param vec1
   The first vector or point to add.
   
   \param Vec2D
   The second vector or point to add.
   */
  /******************************************************************************/
  void Vec2DAdd( Vec2D& result, const Vec2D& vec1, const Vec2D& vec2 )
  {
    result.x = vec1.x + vec2.x;
    result.y = vec1.y + vec2.y;
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
  void Vec2DSub( Vec2D& result,const Vec2D& vec1,const Vec2D& vec2 )
  {
    result.x = vec1.x - vec2.x;
    result.y = vec1.y - vec2.y;
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
  void Vec2DScale( Vec2D& result, const Vec2D& toScale, float scale )
  {
    result.x = toScale.x * scale;
    result.y = toScale.y * scale;
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
  float Vec2DCrossZ( const Vec2D& vec1, const Vec2D& vec2 )
  {
    return (vec1.x * vec2.y) - (vec2.x * vec1.y);
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
  void Vec2DNormalize( Vec2D& result, const Vec2D& toNormalize )
  {
    float length = Vec2DLength(toNormalize);
    
    //DEBUG_ASSERT(!FloatIsEqual(length, 0.f),
    //"Normalizing the zero vector");
    
    result.x = toNormalize.x/length;
    result.y = toNormalize.y/length;
  }
  /******************************************************************************/
  /*!
   Calculates the projection vector of vec1 onto Vec2D.
   
   \param result
   A pointer to a vector to store the result.
   
   
   \param vec1
   The vector you are projecting.
   
   \param vec2
   The vector you are projecting onto.
   */
  /******************************************************************************/
  void Vec2DProject( Vec2D& result, const Vec2D& vec1, const Vec2D& vec2 )
  {
    /*Projection is (v.w)/(w.w)*w */
    
    /*Get the dot product*/
    float dotProduct = Vec2DDot(vec1, vec2);
    /*Get the length squared*/
    float lengthSquared = Vec2DDot(vec2,vec2);
    
    //DEBUG_ASSERT(!FloatIsEqual(lengthSquared, 0.0f),
    // "Trying to Project onto the zero vector");
    
    /*Scale the vector;*/
    Vec2DScale(result, vec2, (dotProduct/lengthSquared));
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
  void Vec2DPerpProject( Vec2D& result,const Vec2D& vec1,const Vec2D& vec2 )
  {
    /*Perpendictual Projection is v -(v.w)/(w.w)*w */
    Vec2D projection;
    Vec2DProject(projection, vec1, vec2);
    Vec2DSub(result, vec1, projection);
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
  void Vec2DLerp( Vec2D& result, const Vec2D& vec1, const Vec2D& vec2, float time )
  {
    Vec2D difference;
    
    Vec2DSub(difference, vec2, vec1);
    result.x = vec1.x + difference.x * time;
    result.y = vec1.y + difference.y * time;
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
  float Vec2DDot( const Vec2D& vec1, const Vec2D& vec2 )
  {
    return (vec1.x * vec2.x) + (vec1.y * vec2.y);
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
  float Vec2DLength( const Vec2D& vec )
  {
    /*Use sqrt to get length*/
    return std::sqrt(Vec2DLengthSquared(vec));
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
  float Vec2DLengthSquared( const Vec2D& vec )
  {
    /*Do dot product with itself to get length squared.*/
    return Vec2DDot(vec, vec);
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
  float Vec2DDistance( const Vec2D& vec1, const Vec2D& vec2 )
  {
    /*Get the Square root of the squared version.*/
    return sqrtf(Vec2DDistanceSquared(vec1, vec2));
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
  float Vec2DDistanceSquared( const Vec2D& vec1, const Vec2D& vec2 )
  {
    Vec2D vec;
    
    /*Get the vector between them*/
    Vec2DSub(vec, vec2, vec1);
    /*Get the length of that vector squared*/
    return Vec2DLengthSquared(vec);
  }
  /******************************************************************************/
  /*!
   Tests if two Vec2D are equal.
   
   \param vec1
   A pointer to the first Vec2D to test.
   
   \param vec2
   A pointer to the second Vec2D to test.
   
   \return
   True if the Vec2D are the same, false otherwise.
   */
  /******************************************************************************/
  bool Vec2DEqual( const Vec2D& vec1, const Vec2D& vec2 )
  {
    /*Test if the difference is really close to zero*/
    return (std::fabs(vec1.x-vec2.x) < EPSILON &&
            std::fabs(vec1.y-vec2.y) < EPSILON );
    
  }
  /******************************************************************************/
  /*!
   Tests if two Vec2D are not equal.
   
   \param vec1
   A pointer to the first Vec2D to test.
   
   \param vec2
   A pointer to the second Vec2D to test.
   
   \return
   True if the Vec2D are not the same, false otherwise.
   */
  /******************************************************************************/
  bool Vec2DNotEqual( const Vec2D& vec1, const Vec2D& vec2 )
  {
    /*Just get the opposite of Equal*/
    return !Vec2DEqual(vec1, vec2);
  }
  /******************************************************************************/
  /*!
   Tests if the x, y members are zero
   
   \param vec
   A pointer to the Vec2D to test.
   
   \return
   Returns true if the x, y are zero. False otherwise
   */
  /******************************************************************************/
  bool Vec2DIsZero( const Vec2D& vec )
  {
    /*Test if they are really close to zero*/
    return (std::fabs(vec.x) < EPSILON && std::fabs(vec.y) < EPSILON);
  }

}//end namespace Math
