/******************************************************************************/
/*
 File:   Distance.mm
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to calculate the distace from various shapes
 */
/******************************************************************************/
#ifndef Distance_h
#define Distance_h

#include "Vec2D.h"

namespace Distance
{
  float PointCircle(const Math::Vec2D& point, const Math::Vec2D& circleCenter,
                            float radius);
  float PointRect(const Math::Vec2D& point, const Math::Vec2D& Center,
                          float width, float height);
  float PointLine(const Math::Vec2D& point, const Math::Vec2D& lineStart,
                          const Math::Vec2D& lineEnd);
  float CircleCircle(const Math::Vec2D& circleCenter0, float radius0,
                             const Math::Vec2D& circleCenter1, float radius1);
  float CircleRect(const Math::Vec2D& circleCenter, float radius,
                           const Math::Vec2D& rectCenter, float width, float height);
  float CircleLine(const Math::Vec2D& circleCenter, float radius,
                           const Math::Vec2D& lineStart,
                           const Math::Vec2D& lineEnd);
  float RectRect(const Math::Vec2D& rectCenter0,
                         float width0, float height0,
                         const Math::Vec2D& rectCenter1,
                         float width1, float height1);
}//end namespace Distance

#endif /* Distance_h */
