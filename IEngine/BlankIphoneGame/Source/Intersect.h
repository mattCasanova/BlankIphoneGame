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

int IntersectPointCircle(const Vec2* point, const Vec2* center, float radius);
int IntersectPointRect(const Vec2* point, const Vec2* center,
                float width, float height);
int IntersectCircleCircle(const Vec2* center0, float radius0,
                    const Vec2* center1, float radius1);
int IntersectCircleRect(const Vec2* circleCenter, float radius,
                  const Vec2* rectCenter, float width, float height);
int IntersectCircleLine(const Vec2* center, float radius,
                  const Vec2* start, const Vec2* end);
  
int IntersectRectRect(const Vec2* center0, float width0, float height0,
                const Vec2* center1, float width1, float height1);



#endif /* Intersect_h */
