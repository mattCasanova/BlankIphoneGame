/******************************************************************************/
/*
 File:   Input.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/05/27
 
 
 This class is responsable for getting touch info from IOS and presenting it
 to the game states
 */
/******************************************************************************/
#import <Foundation/Foundation.h>
#import "Vec2D.h"


/******************************************************************************/
/*
 Simple struct to present touch information to the game states
 
 if there is no touch this frame touch location is guarenteed to be off screen
 */
/******************************************************************************/
typedef struct
{
  Vec2  touchLoc; //!< The location of the current touch
  BOOL  isTouched;//!< IF the screen was touched this frame
}TouchData;


/******************************************************************************/
/*
 Class to get and set touch data.  The ViewController is repsosible for 
 setting the touch information, so typcally the game states will only need to
 call GetTouchData to read that data.  
 */
/******************************************************************************/
@interface Input : NSObject

-(Input*)init;
-(void)SetIsTouched:(BOOL) isTouched atLocation:(const Vec2*) location;
-(const TouchData*)GetTouchData;


@end
