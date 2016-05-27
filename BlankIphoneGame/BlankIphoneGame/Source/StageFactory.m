//
//  StageFactory.m
//  BlankIphoneGame
//
//  Created by Matt Casanova on 5/27/16.
//  Copyright © 2016 Virtual Method. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StageFactory.h"
#import "StageBuilder.h"
#import "StageType.h"

//private data
@interface StageFactory()
{
  NSMutableDictionary* m_builders; //!< Maps my enum to specific Builder Objects
}
//private functions

@end

@implementation StageFactory


/******************************************************************************/
/*!
 Initializes the StageFactory
 
 \return
Returns a pointer to a StageFactory Object or nil.
 */
/******************************************************************************/
-(StageFactory*)init
{
  self = [super init];
  if(!self)
    return 0;

  //Create my Dictionary with enough Space for every Stage
  m_builders = [NSMutableDictionary dictionaryWithCapacity:ST_COUNT];

  return self;
}
/******************************************************************************/
/*!
 Adds a StageBuilder to the factory that can be accessed with the given
 StageType enum
 
 \param builder
 The specific StageBuilder to be associated with the given StageType
 
 \param type
 The StageType that can be used to access the given builder.
 
 */
/******************************************************************************/
-(void)addBuilder:(id<StageBuilder>) builder OfType: (StageType)type
{
  //Convert our enum for dictionary
  NSNumber* number = [NSNumber numberWithInteger:type];
  
  //Check if the builder already exists
  id found = [m_builders objectForKey:number];
  NSAssert(found == nil, @"Trying to Add a builder that Already Exists");
  
  //If it doesn't exist, we can add it
  [m_builders setObject:builder forKey:number];
}
/******************************************************************************/
/*!
 Removes associated builder from the factory if it was added.  Asserts otherwise
 
 \param type
 The StageType to be removed.
 
 */
/******************************************************************************/
-(void)removeBuilderOfType:(StageType)type
{
  //Convert our enum for dictionary
  NSNumber* number = [NSNumber numberWithInteger:type];
  
  //Check if the builder already exists
  id found = [m_builders objectForKey:number];
  NSAssert(found != nil, @"Trying to Remove a builder that doesn't exist");
  
  //We can now safely remove the the builder
  [m_builders removeObjectForKey:number];

}
/******************************************************************************/
/*!
 Instaciates a Stage of based on the Given StageType
 
 \param type
 The StageType to be removed.
 
 */
/******************************************************************************/
-(id<Stage>)CreateStageOfType:(StageType)type
{
  //Convert our enum for dictionary
  NSNumber* number = [NSNumber numberWithInteger:type];
  
  //Check if the builder already exists
  id<StageBuilder> builder = [m_builders objectForKey:number];
  NSAssert(builder != nil, @"Trying to Use a builder that doesn't exist");
  
  return [builder create];
  
}


@end