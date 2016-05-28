//
//  Input.m
//  BlankIphoneGame
//
//  Created by Matt Casanova on 5/27/16.
//  Copyright © 2016 Virtual Method. All rights reserved.
//

#import "Input.h"


#define NO_TOUCH -1000.f


//private data
@interface Input ()
{
  TouchData m_touchData;
}
//private methods

@end


@implementation Input

-(Input*)init
{
  self = [super init];
  if(!self)
    return 0;
  
  
  m_touchData.touchLoc.x = NO_TOUCH;
  m_touchData.touchLoc.y = NO_TOUCH;
  m_touchData.isTouched  = NO;
  
  return self;
}
-(void)SetIsTouched:(BOOL) isTouched atLocation:(const Vec2*) location
{
  m_touchData.isTouched = isTouched;
  m_touchData.touchLoc  = *location;
}
-(const TouchData*)GetTouchData
{
  return &m_touchData;
}


@end
