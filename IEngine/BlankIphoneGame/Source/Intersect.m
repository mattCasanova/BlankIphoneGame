/******************************************************************************/
/*
 File:   Intersect.mm
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to calculate if two shapes are intersecting.
 */
/******************************************************************************/
#include "Intersect.h"

#include "GameMath.h"
#include "Distance.h"

/******************************************************************************/
/*!
 Tests for intersection between a point and a circle.
 
 \param point
 The location of the point.
 
 \param center
 The location of the center of the circle.
 
 \param radius
 The radius of the circle.
 
 \return
 True if the point is in the circle.  False otherwise.
 */
/******************************************************************************/
int IntersectPointCircle(const Vec2* point, const Vec2* circleCenter, float radius)
{
  return Vec2DistanceSquared(point, circleCenter) - (radius*radius) <= EPSILON;
}
/******************************************************************************/
/*!
 Tests for intersection between a point and a rectangle.
 
 \param point
 The location of the point.
 
 \param center
 The location of the center of the rect.
 
 \param width
 The width of the rectangle.
 
 \param height
 The height of the rectangle.
 
 \return
 True if the point and rect are intersecting.  False otherwise.
 */
/******************************************************************************/
int IntersectPointRect(const Vec2* point, const Vec2* center, float width, float height)
{
  /*We need the have sizes of the rect*/
  float halfWidth  = width  / 2.f;
  float halfHeight = height / 2.f;
  
  /*Move the point into rect space.  Treat the rect like it is at the origin*/
  Vec2 pointInRectSpace;
  Vec2Sub(&pointInRectSpace, point, center);
  
  /*If the point in the rect space is inside the extents of the rect
   Then it is inside the rect*/
  if((pointInRectSpace.x <  halfWidth)  && (pointInRectSpace.x > -halfWidth)  &&
     (pointInRectSpace.y <  halfHeight) && (pointInRectSpace.y > -halfHeight))
  {
    return 1;
  }
  return 0;
}
/******************************************************************************/
/*!
 Test for intersection between two circles.
 
 \param center0
 The location of the center of the first circle.
 
 \param radius0
 The radius of the first circle.
 
 \param center1
 The location of the center of the second circle.
 
 \param radius1
 The radius of the second circle.
 
 \return
 True if the circles are intersecting, false otherwise.
 */
/******************************************************************************/
int IntersectCircleCircle(const Vec2* center0, float radius0, const Vec2* center1, float radius1)
{
  return IntersectPointCircle(center0, center1, radius0 + radius1);
}
/******************************************************************************/
/*!
 Tests for intersection between a circle and a rectangle.
 
 \param circleCenter
 The location of the center of the circle.
 
 \param radius
 The radius of the circle.
 
 \param rectCenter
 The center of the rect.
 
 \param width
 The width of the rectangle.
 
 \param height
 The height of the rectangle.
 
 \return
 TRUE if the circle and rect are intersecting, false otherwise.
 */
/******************************************************************************/
int IntersectCircleRect(const Vec2* circleCenter, float radius,
                const Vec2* rectCenter, float width, float height)
{
  return DistCircleRect(circleCenter, radius, rectCenter,width, height) <= EPSILON;
}
/******************************************************************************/
/*!
 Tests intersection between a circle and a line segment.
 
 \param center
 The center of the circle.
 
 \param radius
 The radius of the circle.
 
 \param start
 The location of the start of the line.
 
 \param end
 The location of the end of the line.
 
 \return
 True if the circle and the line are intersecting, false otherwise.
 */
/******************************************************************************/
int IntersectCircleLine(const Vec2* center, float radius,
                const Vec2* start, const Vec2* end)
{
  return DistCircleLine(center, radius, start, end) <= EPSILON;
}
/******************************************************************************/
/*!
 Test for intersection between to rectangles
 
 \param rectCenter0
 The center of the first rect.
 
 \param width0
 The width of the first rectangle.
 
 \param height0
 The height of the first rectangle.
 
 \param rectCenter1
 The center of the second rectangle.
 
 \param width1
 The width of the second rectangle.
 
 \param height1
 The height of the second rectangle.
 
 \return
 True if the two rectangles are intersecting, false otherwise.
 */
/******************************************************************************/
int IntersectRectRect(const Vec2* rectCenter0, float width0, float height0,
              const Vec2* rectCenter1, float width1, float height1)
{
  return IntersectPointRect(rectCenter0, rectCenter1, width0 + width1, height0 + height1);
}

