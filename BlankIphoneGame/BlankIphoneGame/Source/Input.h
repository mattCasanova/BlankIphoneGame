//
//  Input.h
//  BlankIphoneGame
//
//  Created by Matt Casanova on 5/27/16.
//  Copyright © 2016 Virtual Method. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vec2D.h"

typedef struct t_TouchData
{
  Vec2 touchLoc;
  BOOL  isTouched;
}TouchData;


@interface Input : NSObject




@end
