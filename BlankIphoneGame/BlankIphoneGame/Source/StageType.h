/******************************************************************************/
/*
 File:   StageType.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/14
 
 
Use this to enumerate all of the stage types in your game.  You can use the
 value of the enum as a key in your stage factory.
 */
/******************************************************************************/
#ifndef STAGE_TYPE_H
#define STAGE_TYPE_H

/*List your game stages here for easy stage switching within each stage
 Use the enum value as a key in your stage factory*/
typedef enum {
  ST_INIT,
  ST_COUNT
}StageType;


#endif /* STAGE_TYPE_H */
