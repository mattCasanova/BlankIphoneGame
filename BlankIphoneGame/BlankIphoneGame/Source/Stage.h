/******************************************************************************/
/*
 File:   Stage.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/15
 
 
 This is the base Stage class for menues, levels and whatever.
 */
/******************************************************************************/
#ifndef STAGE_H
#define STAGE_H

#import <Foundation/Foundation.h>

//Foward Declare GameManager
@class GameMgr;

@protocol Stage <NSObject>

-(void)initilizeWithMgr:(GameMgr*) gameMgr;
-(void)update:(float)dt;
-(void)shutdown;

@end


#endif /* STAGE_H */
