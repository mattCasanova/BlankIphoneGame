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

//private data
@interface GameMgr()
{
  StageType m_curr;       //!< To keep track of the current stage we are on
  StageType m_next;       //!< To keep track of the stage will we do next frame
  id        m_stage;      //!< A pointer to the current stage
  BOOL      m_isQuitting; //!< a flag to know when user wants to quit
}
//private functions
-(void)changeStage;
@end

@implementation GameMgr

/******************************************************************************/
/*!
 Gets Stage from factory based on m_curr and sets m_stage to the value 
 returned from the factory

 */
/******************************************************************************/
-(void)changeStage
{
  //set our current stage
  m_curr = m_next;
  //get stage from factory
}

/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param x
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
-(GameMgr*)initWithWidth:(float)width
                  Height:(float)height
              StartStage:(StageType)stageId
{
  //init super class and return null if it didn't work
  self = [super init];
  if(!self)
    return 0;
  
  m_isQuitting = NO;
  m_curr       = stageId;
  m_next       = stageId;
  
  //Init graphics
   _gfx = [[Graphics alloc]initWithWidth:width Height:height];
  
  
  //get start stage from manager and init
  m_stage      = [[InitStage alloc]init];
  [m_stage initilizeWithMgr:self];
  
  return self;
}
/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param x
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
-(void)shutdown
{
  //shutdown current stage
  [m_stage shutdown];
  m_stage = nil;
  
  
  //shutdown engines
  _gfx = nil;
  
}
/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param x
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
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
/******************************************************************************/
/*!
 Returns true if x is in the range of low and high (inclusive).
 
 \param x
 The number to check.
 
 \param low
 The lowest number in the range.
 
 \param high
 The highest number in the range.
 
 \return
 True if x is in the range, false otherwise.
 */
/******************************************************************************/
-(void)setNextStage:(StageType) stageId
{
  m_next = stageId;
}


@end
