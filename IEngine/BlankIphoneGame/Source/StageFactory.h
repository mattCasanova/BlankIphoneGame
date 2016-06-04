/******************************************************************************/
/*
 File:   StageFactory
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   5/27/16
 

 This class is used by the GameManager to create specific stages based 
 on the current StageType enum.
 */
/******************************************************************************/
#ifndef StageFactory_h
#define StageFactory_h

#import <Foundation/Foundation.h>
#import "StageType.h"
#import "StageBuilder.h"

/******************************************************************************/
/*!
 Class responsible for holding Builder Objects and instatiating Specific 
 Stages.
 */
/******************************************************************************/
@interface StageFactory : NSObject

-(StageFactory*)init;
-(void)dealloc;
-(void)addBuilder:(id<StageBuilder>) builder OfType: (StageType)type;
-(void)removeBuilderOfType:(StageType)type;
-(id<Stage>)CreateStageOfType:(StageType)type;

@end



#endif /* StageFactory_h */
