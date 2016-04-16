/******************************************************************************/
/*
 File:   Distance.mm
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to calculate the distace from various shapes
 */
/******************************************************************************/
#include "Distance.h"

#include "GameMath.h"
#include <math.h>

/******************************************************************************/
/*!
 Get the distance from a point to a circle.
 
 \param pPoint
 The location of the point.
 
 \param pCircleCenter
 The location of the circle center
 
 \param radius
 The radius of the circle
 
 \return
 The distance from the point to the circle.  A negative distance means the
 point is in the circle.
 */
/******************************************************************************/
float DistPointCircle(const Vec2* point, const Vec2* center, float radius)
{
  return Vec2Distance(point, center) - radius;
}
/******************************************************************************/
/*!
 Gets the distance from a point to a rect.
 
 \param pPoint
 The location of the point.
 
 \param pRectCenter
 The location of the rect center.
 
 \param width
 The width of the rect.
 
 \param height
 The height of the rect.
 
 \return
 The distance from the point to the rect. A negative distance means
 the point is in the rect.
 */
/******************************************************************************/
float DistPointRect(const Vec2* point, const Vec2* center, float width, float height)
{
  /*We are given the full width and height, but we only need half*/
  float distance;
  float halfWidth = width / 2.f;
  float halfHeight = height / 2.f;
  
  Vec2 pointInRectSpace;
  Vec2 closestOnRect;
  
  /*Move the point into rect space.  Shift the point and treat it like the rect
   is at the origin.  This way the calculation only need halfSize and no offset
   */
  Vec2Sub(&pointInRectSpace, point, center);
  
  /*Find the closest point on the rect*/
  closestOnRect.x = Clamp(pointInRectSpace.x, -halfWidth, halfWidth);
  closestOnRect.y = Clamp(pointInRectSpace.y, -halfHeight, halfHeight);
  
  distance = Vec2Distance(&pointInRectSpace, &closestOnRect);
  
  /*Check if the point is in the rect*/
  if( (pointInRectSpace.x <  halfWidth)  &&
     (pointInRectSpace.x > -halfWidth)  &&
     (pointInRectSpace.y <  halfHeight) &&
     (pointInRectSpace.y > -halfHeight) )
  {
    /*Swap the sign*/
    distance *= 1.f;
  }
  
  return distance;
}
/******************************************************************************/
/*!
 Gets the distance from a point to a line segment.
 
 \param pPoint
 The location of the point.
 
 \param pLineStart
 The start location of the line segment.
 
 \param pLineEnd
 The end location of the line segment.
 
 \return
 The distance from the line to the point
 
 */
/******************************************************************************/
float DistPointLine(const Vec2* point, const Vec2* start, const Vec2* end)
{
  Vec2  lineVec;/*The vector of the line*/
  Vec2  normLineVec;/*for the normalized Line vector*/
  Vec2  pointVec;/*The vector from lineStart to the point*/
  float segmentLength;
  float projectedLength;
  float distanceToLineSquared;
  
  /*Get line vector*/
  Vec2Sub(&lineVec, end, start);
  /*Get the vector to the point*/
  Vec2Sub(&pointVec, point, start);
  
  /*Get segment length*/
  segmentLength = Vec2Length(&lineVec);
  
  /*If the segment is very very small, considerate a point*/
  if (segmentLength <= EPSILON)
    return Vec2Length(&pointVec);
  
  /*If the line is more than just a point, project the point onto the line
   and get the length of the projected vector*/
  
  /*First normalize the line vector*/
  Vec2Normalize(&normLineVec, &lineVec);
  
  /*Then project*/
  projectedLength = Vec2Dot(&pointVec, &normLineVec);
  
  /*
   If the projected length is before the start of the segment,
   the closest point is the start
   */
  if(projectedLength <= 0.f)
    return Vec2Length(&pointVec);
  else if(projectedLength >= segmentLength)
    return Vec2Distance(point, end);
  
  /*
   If we got here, the projection vector is within the line segment
   Now we can use Pythagorean theorem to get the unknown side of the triangle.
   */
  distanceToLineSquared = Vec2LengthSquared(&pointVec) - (projectedLength * projectedLength);
  
  /*
   if the floating point error causes the length to be less than zero or
   */
  if(distanceToLineSquared < 0.f || fabsf(distanceToLineSquared) <= EPSILON)
    return 0.f;
  
  /*Otherwise just get distance*/
  return sqrtf(distanceToLineSquared);
}
/******************************************************************************/
/*!
 Gets the distance between two circles.
 
 \param pCircleCenter0
 The center of the first circle.
 
 \param radius0
 The radius of the first circle.
 
 \param pCircleCenter1
 The center of the second circle.
 
 \param radius1
 The radius of the second circle.
 
 \return
 The distance between the two circles.  A value of zero or negative means they
 are intersecting.
 */
/******************************************************************************/
float DistCircleCircle(const Vec2* center0, float radius0, const Vec2* center1, float radius1)
{
  return DistPointCircle(center0, center1, radius0 + radius1);
}
/******************************************************************************/
/*!
 Gets the distance from a circle to a rectangle.
 
 \param pCircleCenter
 The center of the circle.
 
 \param radius
 The radius of the circle.
 
 \param pRectCenter
 The center of the rectangle.
 
 \param width
 The width of the rect.
 
 \param height
 The height of the rect.
 
 \return
 The distance between the circle and rectangle.  A value of zero or negative
 means they are intersecting.
 */
/******************************************************************************/
float DistCircleRect(const Vec2* circleCenter, float radius,
                 const Vec2* rectCenter, float width, float height)
{
  return DistPointRect(circleCenter, rectCenter, width, height) - radius;
}
/******************************************************************************/
/*!
 Gets the distance from a circle to a line segment.
 
 \param pCircleCenter
 The center of the circle.
 
 \param radius
 The radius of the circle.
 
 \param pLineStart
 The start location of the line.
 
 \param pLineEnd
 The end location of the line.
 
 \return
 The distance from the circle to the line segment. A value of zero or negative
 means they are intersecting.
 */
/******************************************************************************/
float DistCircleLine(const Vec2* center, float radius, const Vec2* start, const Vec2* end)
{
  return DistPointLine(center, start, end) - radius;
}
/******************************************************************************/
/*!
 Gets the distance between two rectangles.
 
 \param pRectCenter0
 The center of the first rectangle.
 
 \param width0
 The width of the first rectangle.
 
 \param height0
 The height of the first rectangle.
 
 \param pRectCenter1
 The center of the second rectangle.
 
 \param width1
 The width of the second rectangle.
 
 \param height1
 The height of the second rectangle.
 
 \return
 The distance between the two rectangles. A value of zero or negative means
 they are intersecting.
 */
/******************************************************************************/
float DistRectRect(const Vec2* center0, float width0, float height0,
               const Vec2* center1, float width1, float height1)
{
  return DistPointRect(center0, center1, width0 + width1, height0 + height1);
}

