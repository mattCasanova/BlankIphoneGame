/******************************************************************************/
/*
 File:   ObjectMgr.m
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/06/15
 
 
 Class to handle creating and deleteing objects and buttons.  For now it will
 be very simple but later it will use an object factory to help create
 behavoir for specific types.
 */
/******************************************************************************/
#import "ObjectMgr.h"

//private data
@interface ObjectMgr()
{
  Object* m_objects;
  Button* m_buttons;
}
//private methods

@end


@implementation ObjectMgr

-(ObjectMgr*)initWithMaxObjects:(int)maxObject MaxButtons:(int)maxButtons
{
  return nil;
}
-(void)dealloc
{
  
}

//Object methods
-(Object*)getObjects
{
  return 0;
}
-(int)getObjectCount
{
  return 0;
}
-(void)deleteObject:(int)objectID
{
  
}
-(Object*)addObjectWithPos:(const Vec2*) pos Vel:(const Vec2*)vel
                     Scale:(const Vec2*) scale Rotation:(float)rot
{
  return 0;
}

//button methods
-(Button*)getButtons
{
  return 0;
}
-(int)getButtonCount
{
  return 0;
}
-(void)deleteButton:(int)buttonID
{
  
}
-(Button*)addButtonWithPos:(const Vec2*) pos Scale: (const Vec2*)scale
{
  return 0;
}


@end
