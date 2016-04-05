/******************************************************************************/
/*
 File:   main.m
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/03
 
 The entrance to the program.  This file contains the main function which 
 in turn calls an Objective C version of main to begin our application.
 */
/******************************************************************************/
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char* argv[]) {
  @autoreleasepool {
      return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
