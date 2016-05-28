/******************************************************************************/
/*
 File:   Distance.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains functions to calculate the distace from various shapes
 */
/******************************************************************************/
#ifndef DISTANCE_H
#define DISTANCE_H

#include "Vec2D.h"


float DistPointCircle(const Vec2* point, const Vec2* circleCenter, float radius);
float DistPointRect(const Vec2* point, const Vec2* Center, float width, float height);
float DistPointLine(const Vec2* point, const Vec2* lineStart, const Vec2* lineEnd);
float DistCircleCircle(const Vec2* circleCenter0, float radius0,
                   const Vec2* circleCenter1, float radius1);
float DistCircleRect(const Vec2* circleCenter, float radius,
                 const Vec2* rectCenter, float width, float height);
float DistCircleLine(const Vec2* circleCenter, float radius,
                 const Vec2* lineStart,
                 const Vec2* lineEnd);
float DistRectRect(const Vec2* rectCenter0, float width0, float height0,
               const Vec2* rectCenter1, float width1, float height1);
#endif /* Distance_h */
