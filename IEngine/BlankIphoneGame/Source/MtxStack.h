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
#ifndef MTXSTACK_H
#define MTXSTACK_H


#import <Foundation/Foundation.h>
#import "Mtx44.h"


/******************************************************************************/
/*!
 A matrix stack class used for easily storing and concatinating matricies 
 for passing to a shader.
 */
/******************************************************************************/
@interface MtxStack : NSObject

-(MtxStack*)initWithStartSize:(int)startSize;
-(void)dealloc;

-(const Mtx44*)top;
-(void)load:(const Mtx44*)mtx;
-(void)push:(const Mtx44*)mtx;
-(void)pop;
-(void)clear;
-(BOOL)isEmpty;

@end


#endif /* MTXSTACK_H */
