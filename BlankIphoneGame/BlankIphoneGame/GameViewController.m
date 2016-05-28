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
#import "GameMgr.h"


int textureID;

@interface GameViewController ()
{
  GameMgr* m_gameMgr;
  float    m_gameWidth;
  float    m_gameHeight;
  float    m_screenWidth;
  float    m_screenHeight;
}
@property (strong, nonatomic) EAGLContext* pContext;


@end

@implementation GameViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  CGPoint raw = [[touches anyObject] locationInView:self.view];
  Vec2 touch;
  touch.x = raw.x * m_gameWidth / m_screenWidth;
  touch.y = raw.y * m_gameHeight / m_screenHeight;
  [[m_gameMgr input]SetIsTouched:YES atLocation:&touch];
  
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
  CGPoint raw = [[touches anyObject] locationInView:self.view];
  Vec2 touch;
  touch.x = raw.x * m_gameWidth / m_screenWidth;
  touch.y = raw.y * m_gameHeight / m_screenHeight;
  [[m_gameMgr input]SetIsTouched:YES atLocation:&touch];
  
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
  Vec2 touch = {-1000.f, -1000.f};
  [[m_gameMgr input]SetIsTouched:NO atLocation:&touch];
}

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
  [EAGLContext setCurrentContext:self.pContext];
  

  //configure the current view for our game
  GLKView *view = (GLKView *)self.view;
  view.context = self.pContext;
  view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
  self.preferredFramesPerSecond = 30;
  
  
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
  
  m_gameMgr = [[GameMgr alloc]initWithWidth:m_screenWidth//m_gameWidth
                                     Height:m_screenHeight//m_gameHeight
                                 StartStage:ST_INIT];
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
  
  
  m_gameMgr = nil;
}
/******************************************************************************/
/*
   Message to handle if application is running out of memory.
 */
/******************************************************************************/
- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

  if ([self isViewLoaded] && ([[self view] window] == nil))
  {
    self.view = nil;
    m_gameMgr = nil;
    
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
  [m_gameMgr update:self.timeSinceLastUpdate];
}




@end
