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

namespace Math
{
  /******************************************************************************/
  /*!
   Gets the matrix at the top of the stack
   
   \return
   The top matrix
   */
  /******************************************************************************/
  const Mtx44& MtxStack::Top(void) const
  {
    return m_stack.top();
  }
  /******************************************************************************/
  /*!
   Cleans the old stack and places the loaded mtx44 as the only matrix in the
   stack.
   
   \param mtx
   The new top of the stack
   */
  /******************************************************************************/
  void MtxStack::Load(const Mtx44& mtx)
  {
    Clear();
    m_stack.push(mtx);
  }
  /******************************************************************************/
  /*!
   Multiplies the top matrix by the parameter and stores it in the new top.
   
   \param mtx
   The matrix to multiply
   */
  /******************************************************************************/
  void MtxStack::Push(const Mtx44& mtx)
  {
    Mtx44 result;
    Mtx44Mult(result, mtx,m_stack.top() );
    m_stack.push(result);
  }
  /******************************************************************************/
  /*!
   Removes the top matrix from the stack.
   */
  /******************************************************************************/
  void MtxStack::Pop(void)
  {
    //DEBUG_ASSERT(m_stack.empty() == false, "Trying to pop an empty stack.");
    m_stack.pop();
  }
  /******************************************************************************/
  /*!
   Clears all of the matrices from the stack.
   */
  /******************************************************************************/
  void MtxStack::Clear(void)
  {
    //m_stack.swap(std::stack<Mtx44>());
    while(!m_stack.empty())
      m_stack.pop();
  }
  /******************************************************************************/
  /*!
   Returns the the number of matricies on the stack
   */
  /******************************************************************************/
  int MtxStack::Size(void) const
  {
    return static_cast<int>(m_stack.size());
  }

}//end namespace Math
