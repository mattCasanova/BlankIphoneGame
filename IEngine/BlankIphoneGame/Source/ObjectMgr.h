/******************************************************************************/
/*
 File:   ObjectMgr.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/06/15
 
 
 Class to handle creating and deleteing objects and buttons.  For now it will
 be very simple but later it will use an object factory to help create
 behavoir for specific types.
 */
/******************************************************************************/
#import <Foundation/Foundation.h>
#import "Objects.h"
#import "Vec2D.h"


@interface ObjectMgr : NSObject

-(ObjectMgr*)initWithMaxObjects:(int)maxObject MaxButtons:(int)maxButtons;
-(void)dealloc;

//Object methods
-(Object*)getObjects;
-(int)getObjectCount;
-(void)deleteObject:(int)objectID;
-(Object*)addObjectWithPos:(const Vec2*) pos Vel:(const Vec2*)vel
                     Scale:(const Vec2*) scale Rotation:(float)rot;

//button methods
-(Button*)getButtons;
-(int)getButtonCount;
-(void)deleteButton:(int)buttonID;
-(Button*)addButtonWithPos:(const Vec2*) pos Scale: (const Vec2*)scale;

@end
