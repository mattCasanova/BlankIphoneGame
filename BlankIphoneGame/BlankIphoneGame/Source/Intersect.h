/******************************************************************************/
/*
 File:   Intersect.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to calculate if two shapes are intersecting.
 */
/******************************************************************************/
#ifndef Intersect_h
#define Intersect_h


#include "Vec2D.h"

namespace Intersect
{
  bool PointCircle(const Math::Vec2D& point, const Math::Vec2D& center, float radius);
  bool PointRect(const Math::Vec2D& point, const Math::Vec2D& center,
                float width, float height);
  bool CircleCircle(const Math::Vec2D& center0, float radius0,
                    const Math::Vec2D& center1, float radius1);
  bool CircleRect(const Math::Vec2D& circleCenter, float radius,
                  const Math::Vec2D& rectCenter, float width, float height);
  bool CircleLine(const Math::Vec2D& center, float radius,
                  const Math::Vec2D& start, const Math::Vec2D& end);
  
  bool RectRect(const Math::Vec2D& center0, float width0, float height0,
                const Math::Vec2D& center1, float width1, float height1);
}//end namespace Intersect


#endif /* Intersect_h */
