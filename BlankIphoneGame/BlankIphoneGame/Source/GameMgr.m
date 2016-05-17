/******************************************************************************/
/*
 File:   GameMgr.m
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/14
 
 
 The Game Manager is resposible for state switching, managing core engine
 components and holding shared game data.
 */
/******************************************************************************/
#import "GameMgr.h"
#import "Graphics.h"
#import "InitStage.h"

@interface GameMgr()
{
  StageType m_curr;
  StageType m_next;
  id    m_stage;
  BOOL      m_isQuitting;
}

-(void)changeStage;


@end

@implementation GameMgr

-(GameMgr*)initWithWidth:(float)width Height:(float)height StartStage:(StageType)stageId
{
  self = [super init];
  if(!self)
    return 0;
  
  m_isQuitting = NO;
  m_curr       = stageId;
  m_next       = stageId;
   _gfx = [[Graphics alloc]initWithWidth:width Height:height];
  m_stage      = [[InitStage alloc]init];
  [m_stage initilizeWithMgr:self];
  
 
  

  return self;
}
-(void)shutdown
{
  [m_stage shutdown];
  m_stage = nil;
  
  //shutdown engines
  _gfx = nil;
  
}
-(void)update:(float)dt
{
  if(m_curr == m_next && !m_isQuitting)
  {
    [m_stage update:dt];
  }
  else
  {
    [m_stage shutdown];
    [self changeStage];
    [m_stage initilizeWithMgr:self];
  }
}
-(void)setNextStage:(StageType) stageId
{
  m_next = stageId;
}
-(void)changeStage
{
  m_curr = m_next;
  //get stage from factory
}

@end
