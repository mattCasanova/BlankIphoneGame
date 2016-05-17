//
//  InitStage.m
//  BlankIphoneGame
//
//  Created by Matt Casanova on 4/16/16.
//  Copyright © 2016 Virtual Method. All rights reserved.
//

#import "InitStage.h"
#import "GameMgr.h"
#import "Mtx44.h"

@implementation InitStage
{
  GameMgr* m_gameMgr;
  int textureID;
}

-(void)initilizeWithMgr:(GameMgr*) gameMgr
{
  m_gameMgr = gameMgr;
  textureID = [m_gameMgr.gfx loadTexture:@"Test.png"];
}
-(void)update:(float)dt
{
  static float rot = 0;
  rot += .05f;
  Mtx44 world;
  Mtx44MakeTransform(&world, 100, 100, rot, 100, 100, 0);
  
  [m_gameMgr.gfx setBackgroundRed:.5 Green:.5 Blue:1];
  [m_gameMgr.gfx setTexture:textureID];
  [m_gameMgr.gfx clearScreen];
  [m_gameMgr.gfx draw:&world];
  [m_gameMgr.gfx present];

}
-(void)shutdown
{
  [m_gameMgr.gfx unloadTexture:textureID];
}

@end
