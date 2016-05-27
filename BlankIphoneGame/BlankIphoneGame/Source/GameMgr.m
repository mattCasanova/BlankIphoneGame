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
#import "StageFactory.h"
#import "Graphics.h"
#import "StageFactory.h"
#import "InitStage.h"

//private data
@interface GameMgr()
{
  StageType     m_curr;       //!< Enum of current stage we are on
  StageType     m_next;       //!< Enum of stage will we do next frame
  id            m_stage;      //!< A pointer to the current stage
  BOOL          m_isQuitting; //!< A flag to know when user wants to quit
  StageFactory* m_factory;    //!< Instantiate stage based on enum
  
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
              StartStage:(StageType)startStage
{
  //init super class and return null if it didn't work
  self = [super init];
  if(!self)
    return 0;
  
  m_isQuitting = NO;
  m_curr       = startStage;
  m_next       = startStage;
  
  //Init graphics
   _gfx = [[Graphics alloc]initWithWidth:width Height:height];
  
  //Init input
  
  //Init Factory
  m_factory = [[StageFactory alloc]init];
  
  
  //Add My Builders
  id builder = [[InitStageBuilder alloc]init];
  [m_factory addBuilder:builder OfType:ST_INIT];
  
  //get start stage from manager and init
  m_stage      = [m_factory CreateStageOfType:startStage];
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
  //shutdown current stage and factory
  [m_stage shutdown];
  m_stage = nil;
  m_factory = nil;
  
  
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
-(void)setNextStage:(StageType) nextStage
{
  m_next = nextStage;
}


@end
