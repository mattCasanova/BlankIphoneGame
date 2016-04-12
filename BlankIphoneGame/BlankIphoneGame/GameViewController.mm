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



@interface GameViewController ()
{
  MyGraphics* m_pGfx;
  float m_gameWidth;
  float m_gameHeight;
  float m_screenWidth;
  float m_screenHeight;
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
  
  m_pGfx = new MyGraphics;
  m_pGfx->Init(self.pContext, m_gameWidth, m_gameHeight);
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
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  if ([self isViewLoaded] && ([[self view] window] == nil))
  {
    self.view = nil;
    
    m_pGfx->Shutdown();
    delete m_pGfx;
    m_pGfx = 0;
    
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
  m_pGfx->SetBackGroundColor(.5, .5, 1);
  m_pGfx->StartDraw();
  m_pGfx->EndDraw();
}




@end
