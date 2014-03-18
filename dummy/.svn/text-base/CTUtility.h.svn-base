//
//  Utility.h
//  RagDoll
//
//  Created by Exponere Entertainment on 4/5/11.
//  Copyright 2011 Muhammed Ali Khan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"


@interface CTUtility : NSObject {

}
+(b2Vec2) toMeters:(CGPoint)point;
+(CGPoint) toPixels:(b2Vec2)point; 
+(CGPoint) getNormalizedLocation:(NSSet*)touches;
+(void) keepWithInBounds:(CCNode *) aNode ofDimensions:(CGSize) aDimensions;
+(BOOL) hitTestObject:(CCSprite *)obj1 With:(CCSprite *)obj2;
+(b2Body *) getBodyForSprite:(CCSprite *)spriteOnStage inWorld:(b2World *)world_instance;
+(BOOL) containsBody:(b2Body *)world_body inWorld:(b2World *)world_instance;
@end
