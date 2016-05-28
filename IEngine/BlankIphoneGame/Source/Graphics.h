/******************************************************************************/
/*
 File:   Graphics.h
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/010
 

 The Graphics class is repsonsible for loading and drawing textures on the 
 screen.
 */
/******************************************************************************/
#ifndef GRAPHICS_H
#define GRAPHICS_H

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>
#import "Mtx44.h"


@interface Graphics : NSObject

-(Graphics*)initWithWidth:(float)width Height:(float)height;
-(void)dealloc;

-(void)clearScreen;
-(void)present;
-(void)draw:(const Mtx44*)world;

-(int)loadTexture:(NSString*)fileName;
-(void)unloadTexture:(int)textureID;

-(void)setTexture:(int)textureID;
-(void)setTextureScaleX:(float)sX
                 ScaleY:(float)sY
                 TransX:(float)tX
                 TransY:(float)tY;
-(void)setTextureRed:(float)red
               Green:(float)green
                Blue:(float)blue
               Alpha:(float)alpha;

-(void)setBackgroundRed:(float)red
                  Green:(float)green
                   Blue:(float)blue;
@end


#endif //end GRAPHICS_H
