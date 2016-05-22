/******************************************************************************/
/*
 File:   GameMgr.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/14
 

 The Game Manager is resposible for state switching, managing core engine 
 components and holding shared game data.
 */
/******************************************************************************/
#ifndef GAME_MGR_H
#define GAME_MGR_H

#import <Foundation/Foundation.h>
#import "StageType.h"
#import "Graphics.h"
#include "Vec2D.h"

typedef struct t_TouchData
{
  Vec2 touchLoc;
  BOOL  isTouched;
}TouchData;

/******************************************************************************/
/*!
 Class resposible for state switching, managing my core engines including
 graphics and audio, as well as holding shared game data
 */
/******************************************************************************/
@interface GameMgr : NSObject

-(GameMgr*)initWithWidth:(float)width
                  Height:(float)height
              StartStage:(StageType)stageId;
-(void)update:(float)dt;
-(void)shutdown;
-(void)setNextStage:(StageType) stageId;


@property(nonatomic, readonly) Graphics* gfx;

@end

#endif /* GameMgr_h */
