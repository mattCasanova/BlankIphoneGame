/******************************************************************************/
/*
 File:   GameViewController.mm
 Author: Matt Casanova
 Email:  lazersquad@gmail.com
 Date:   2016/04/03
 
 This class is responsible for updating the view.  This includes actually
 updating the game (or pausing and resuming), as well as responding to game
 touches.
 */
/******************************************************************************/
#import "GameViewController.h"
#import <OpenGLES/ES2/glext.h>
#import "Graphics.h"
#import "Mtx44.h"

int textureID;

@interface GameViewController ()
{
  Graphics* m_gfx;
  float    m_gameWidth;
  float    m_gameHeight;
  float    m_screenWidth;
  float    m_screenHeight;
}
@property (strong, nonatomic) EAGLContext* pContext;


@end

@implementation GameViewController


/******************************************************************************/
/*
   Gets called when new view is created.
 */
/******************************************************************************/
- (void)viewDidLoad
{
  //Call super
  [super viewDidLoad];
    
  //Create open gl context
  self.pContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  if (!self.pContext)
    NSLog(@"Failed to create ES context");
  

  //configure the current view for our game
  GLKView *view = (GLKView *)self.view;
  view.context = self.pContext;
  view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
  self.preferredFramesPerSecond = 60;
  
  
  //"normalize" width and height
  //TODO: Test what the game looks like with out doing this
  m_screenWidth  = self.view.bounds.size.width;
  m_screenHeight = self.view.bounds.size.height;
  
  if(m_screenWidth > m_screenHeight)
  {
    m_gameHeight = 600;
    m_gameWidth  = m_screenWidth * m_gameHeight / m_screenHeight;
  }
  else
  {
    m_gameWidth  = 600;
    m_gameHeight = m_screenHeight * m_gameWidth/ m_screenWidth;
  }
  
  m_gfx = [[Graphics alloc]initWithContext:self.pContext
                                     Width:m_gameWidth
                                    Height:m_gameHeight];
  textureID = [m_gfx loadTexture: @"Test.png"];
}
/******************************************************************************/
/*
   destructor for my view.
 */
/******************************************************************************/
- (void)dealloc
{
  //TODO: Do I need to do this in ARC
  if ([EAGLContext currentContext] == self.pContext)
        [EAGLContext setCurrentContext:nil];
  
  m_gfx = nil;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  if ([self isViewLoaded] && ([[self view] window] == nil))
  {
    self.view = nil;
    
    m_gfx = nil;
    
    if ([EAGLContext currentContext] == self.pContext)
      [EAGLContext setCurrentContext:nil];
    
    self.pContext = nil;
  }

    // Dispose of any resources that can be recreated.
}
/******************************************************************************/
/*
 Description of how I want the status bar to behave in my game
 */
/******************************************************************************/
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
/******************************************************************************/
/*
   Main update loop for the game
 */
/******************************************************************************/
- (void)update
{
  Math::Mtx44 world;
  Math::Mtx44MakeTransform(world, 100, 100, 0, 300, 300, 0);
  [m_gfx setBackgroundRed:.5 Green:.5 Blue:1];
  [m_gfx setTexture:textureID];
  [m_gfx clearScreen];
  [m_gfx draw:&world];
  [m_gfx present];
}




@end
