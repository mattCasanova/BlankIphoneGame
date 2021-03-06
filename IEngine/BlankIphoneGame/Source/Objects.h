/******************************************************************************/
/*
 File:   Objects.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/06/15
 
 
Header file that defines game objects and buttons.  For now the objects are
 very simple and would need to be changed depending on the game.  Later I 
 will change the object to be component based.
 */
/******************************************************************************/
#ifndef Objects_h
#define Objects_h

#import "Vec2D.h"


//Do I need this
typedef enum{
  OT_MISSILE,
  OT_BASE
}ObjectType;



typedef struct
{
  Vec2  pos;
  Vec2  vel;
  Vec2  scale;
  float rot;
  int   id;
}Object;


typedef struct
{
  Vec2 pos;
  Vec2 scale;
  int  id;
}Button;

#endif /* Objects_h */
