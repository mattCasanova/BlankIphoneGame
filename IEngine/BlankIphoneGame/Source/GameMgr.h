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
#import "Input.h"

/******************************************************************************/
/*!
 Class resposible for state switching, managing my core engines including
 graphics and audio, as well as holding shared game data
 */
/******************************************************************************/
@interface GameMgr : NSObject

-(GameMgr*)initWithWidth:(float)width
                  Height:(float)height
              StartStage:(StageType)startStage;
-(void)dealloc;
-(void)update:(float)dt;

-(void)setNextStage:(StageType) nextStage;


@property(nonatomic, readonly) Graphics* gfx;
@property(nonatomic, strong)   Input*    input;

@end

#endif /* GameMgr_h */
