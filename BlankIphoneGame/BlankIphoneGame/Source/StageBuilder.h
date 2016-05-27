/******************************************************************************/
/*
 File:   StageBuilder.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   5/27/16
 
 
This is an interface for a Builde class.  Each Stage must create a stage builder
So it can be instanciated via the factory in the GameManaager.
 */
/******************************************************************************/
#ifndef StageBuilder_h
#define StageBuilder_h

#import "Stage.h"

/******************************************************************************/
/*!
 interface for a class that is resposible for creating a spcific stage.
 */
/******************************************************************************/
@protocol StageBuilder <NSObject>

-(id<Stage>)create;

@end



#endif /* StageBuilder_h */
