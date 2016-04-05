/******************************************************************************/
/*
 File:   Mtx44.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains definitions for my 4x4 matrix class.
 */
/******************************************************************************/
#ifndef Mtx44_h
#define Mtx44_h

namespace Math
{
  /*! A 4D Matrix for a 2D game, z is used for Z-order.
   \verbatim
   |Xx Xy Xz 0 |
   |Yx Yy Yz 0 |
   |Zx Zy Zz 0 |
   |Tx Ty Tz 1 |
   \endverbatim
   */
  const int ROWS   = 4;/*! The number of rows in the matrix*/
  const int COLS   = 4;/*! The number of columns in the matrix*/
  struct Mtx44
  {
    float m[ROWS][COLS];/*!< Array of 16 floats to represent a 4x4 matrix*/
  };

}//end namespace Math

#endif /* Mtx44_hpp */
