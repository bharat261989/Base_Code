//
//  Utility.m
//  RagDoll
//
//  Created by Exponere Entertainment on 4/5/11.
//  Copyright 2011 Muhammed Ali Khan. All rights reserved.
//

#import "CTUtility.h"
#import "Constants.h"

@implementation CTUtility

+(b2Vec2) toMeters:(CGPoint)point 
{
	return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}
+(CGPoint) toPixels:(b2Vec2)point 
{
	return CGPointMake(point.x * PTM_RATIO, point.y * PTM_RATIO);
}
+(CGPoint) getNormalizedLocation:(NSSet*)touches
{
   
    UITouch* touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
    //location.x = 600;
    //location.y = 100;
    NSLog(@"HGGHGHGHHJGHGHGHH");
    NSLog(@"%@", NSStringFromCGPoint(location));
	return [[CCDirector sharedDirector] convertToGL: location];
}
+(void) keepWithInBounds:(CCNode *) aNode ofDimensions:(CGSize) aDimensions
{
    CGFloat newX = aNode.position.x;
    CGFloat newY = aNode.position.y;
    
    if (aNode.position.x >= 0) {
        newX = 0;
    } else if (aNode.position.x <= -(aDimensions.width) * aNode.scale + 480) {
        newX = -(aDimensions.width) * aNode.scale + 480;
    }
    
    if (aNode.position.y >= 0) {
        newY = 0;        
    } else if (aNode.position.y <= -(aDimensions.height) * aNode.scale + 320) {
        newY = -(aDimensions.height) * aNode.scale + 320;
    }
    //newY = -250;
    [aNode setPosition:ccp(newX,newY)];
}
+(BOOL) hitTestObject:(CCSprite *)obj1 With:(CCSprite *)obj2
{
	CGRect rect1 = CGRectMake(posx(obj1), posy(obj1), width(obj1)*obj1.scale, height(obj1)*obj1.scale);
	CGRect rect2 = CGRectMake(posx(obj2), posy(obj2), width(obj2)*obj2.scale, height(obj2)*obj2.scale);
	if (!CGRectIsNull(CGRectIntersection(rect1, rect2))) {
		return YES;
	} else {
		return NO;
	}
}
+(BOOL) containsBody:(b2Body *)world_body inWorld:(b2World *)world_instance
{
	for (b2Body* b = world_instance->GetBodyList(); b; b = b->GetNext())
	{
		if (b == world_body) {
			return YES;
		}
	}
	return NO;
}
+(b2Body *) getBodyForSprite:(CCSprite *)spriteOnStage inWorld:(b2World *)world_instance
{
	for (b2Body* b = world_instance->GetBodyList(); b; b = b->GetNext())
	{
		CCSprite* spr = (CCSprite *)b->GetUserData();
		if (spr == spriteOnStage) {
			return b;
		}
	}
	return nil;
}

@end
