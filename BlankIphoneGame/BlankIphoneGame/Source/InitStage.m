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
#import "Vec2D.h"
#import "GameMath.h"

@implementation InitStage
{
  GameMgr* m_gameMgr;
  int textureID;
}

-(void)initilizeWithMgr:(GameMgr*) gameMgr
{
  m_gameMgr = gameMgr;
  textureID = [m_gameMgr.gfx loadTexture:@"Test.png"];
  [m_gameMgr.gfx setBackgroundRed:.5 Green:.5 Blue:1];
  [m_gameMgr.gfx setTexture:textureID];
}
-(void)update:(float)dt
{
  static float rot = 0;
  rot += 2.f * dt;
  rot = Wrap(rot, 0, PI * 2);
  Mtx44 world;
  Vec2 mouse;
  

  mouse = [[m_gameMgr input]GetTouchData]->touchLoc;
  Mtx44MakeTransform(&world, 300, 300, rot, mouse.x, mouse.y, 0);
  
  [m_gameMgr.gfx clearScreen];
  [m_gameMgr.gfx draw:&world];
  [m_gameMgr.gfx present];

}
-(void)shutdown
{
  [m_gameMgr.gfx unloadTexture:textureID];
}

@end

@implementation InitStageBuilder

-(id<Stage>)create
{
  return [[InitStage alloc]init];
}

@end
