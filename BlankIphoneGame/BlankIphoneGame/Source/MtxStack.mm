/******************************************************************************/
/*
 File:   MtxStack.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/05
 
 This file contains my matrix stack class for easily concatinating and removing
 matricies for my shaders.
 */
/******************************************************************************/
#include "MtxStack.h"


@interface MtxStack()
{
  Mtx44* m_stack;
  int    m_size;
  int    m_capacity;
}

-(void)grow;

@end

@implementation MtxStack

-(MtxStack*)initWithStartSize:(int)startSize
{
  self = [super init];
  if(!self)
    return 0;

  m_size = 0;
  m_capacity = startSize;
  m_stack = (Mtx44*)malloc(startSize * sizeof(Mtx44));
  
  //if malloc fails
  if(!m_stack)
  {
    self = nil;
    return 0;
  }

  return self;
}
/******************************************************************************/
/*!
 returns resources to the OS
 
 \return
 The top matrix
 */
/******************************************************************************/
-(void)dealloc
{
  m_capacity = m_size = 0;
  free(m_stack);
  m_stack = 0;
}
/******************************************************************************/
/*!
 Gets the matrix at the top of the stack
 
 \return
 The top matrix
 */
/******************************************************************************/
-(const Mtx44*)top
{
  return m_stack + (m_size - 1);
}
/******************************************************************************/
/*!
 Cleans the old stack and places the loaded mtx44 as the only matrix in the
 stack.
 
 \param mtx
 The new top of the stack
 */
/******************************************************************************/
-(void)load:(const Mtx44*)mtx
{
  m_size = 0;
  m_stack[m_size++] = *mtx;
}
-(void)grow
{
  //double capacity and allocate
  m_capacity = m_capacity * 2;
  Mtx44* pNewData = (Mtx44*)malloc(m_capacity * sizeof(Mtx44));
  
  //make sure we have enough space
  NSAssert(pNewData != 0, @"No System Memory");
  
  //copy over data
  for(int i = 0; i < m_size; ++i)
    pNewData[i] = m_stack[i];
  
  free(m_stack);
  m_stack = pNewData;
  
}
/******************************************************************************/
/*!
 Multiplies the top matrix by the parameter and stores it in the new top.
 
 \param mtx
 The matrix to multiply
 */
/******************************************************************************/
-(void)push:(const Mtx44*)mtx
{
  if(m_size == m_capacity)
    [self grow];
  
  Mtx44 result;
  Mtx44Mult(&result, mtx, m_stack + (m_size - 1));
  m_stack[m_size++] = result;
}
/******************************************************************************/
/*!
 Removes the top matrix from the stack.
 */
/******************************************************************************/
-(void)pop
{
  NSAssert(m_size != 0, @"Trying to pop an empty stack");
  --m_size;
}
/******************************************************************************/
/*!
 Clears all of the matrices from the stack.
 */
/******************************************************************************/
-(void)clear
{
  m_size = 0;
}
/******************************************************************************/
/*!
 Returns if the stack is empty or not
 */
/******************************************************************************/
-(BOOL)isEmpty
{
  return m_size == 0;
}


@end

