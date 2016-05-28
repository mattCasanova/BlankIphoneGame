/******************************************************************************/
/*
 File:   Input.m
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/05/27
 
 
 This class is responsable for getting touch info from IOS and presenting it
 to the game states
 */
/******************************************************************************/

#import "Input.h"



//The offscreen position of touch x and y if there is no touch this frame
#define NO_TOUCH -1000.f


//private data
@interface Input ()
{
  TouchData m_touchData;
}
//private methods

@end


@implementation Input

/******************************************************************************/
/*
 Contructor for my input class
 */
/******************************************************************************/
-(Input*)init
{
  self = [super init];
  if(!self)
    return nil;
  
  m_touchData.touchLoc.x = NO_TOUCH;
  m_touchData.touchLoc.y = NO_TOUCH;
  m_touchData.isTouched  = NO;
  
  return self;
}
/******************************************************************************/
/*
 Function for the ViewController to set the touch information.  
 
 Typically the game states should not need to call this method.  Although 
 they can if they want.
 */
/******************************************************************************/
-(void)SetIsTouched:(BOOL) isTouched atLocation:(const Vec2*) location
{
  m_touchData.isTouched = isTouched;
  m_touchData.touchLoc  = *location;
}
/******************************************************************************/
/*
 Function for the game states to get the current touch information this frame.
 */
/******************************************************************************/
-(const TouchData*)GetTouchData
{
  return &m_touchData;
}


@end
