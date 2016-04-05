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
#ifndef MtxStack_h
#define MtxStack_h


#include "Mtx44.h"
#include <stack>

namespace Math
{
  /*A matrix stack that will multiply as a matrix get pushed onto it.*/
  class MtxStack
  {
  public:
    const Mtx44& Top(void) const;
    
    void Load(const Mtx44& mtx);
    void Push(const Mtx44& mtx);
    void Pop(void);
    void Clear(void);
    int  Size(void) const;
    
  private:
    std::stack<Mtx44> m_stack;
  };

}//end namespace math

#endif /* MtxStack_h */
