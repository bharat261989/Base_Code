//
//  ObjectCreator.m
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright (c) 2012 Exponere Entertainment. All rights reserved.
//

#import "ObjectCreator.h"
#import "Constants.h"
static b2World* world = nil;
static CCLayer* parentLayer = nil;

@implementation ObjectCreator
+(void)setWorld:(b2World *)aWorld {
    world = aWorld;
}

+(void)setParentLayer:(CCLayer *)aLayer {
    parentLayer = aLayer;
}

+(PhysicsSpritee *) createFreeCircularBodyWithFile:(NSString *)aFilename atPoint:(CGPoint)aPoint {
    PhysicsSpritee* sprite = [PhysicsSpritee spriteWithFile:aFilename];
    [parentLayer addChild:sprite z:2];
    
    b2BodyDef bodyDef; 
	bodyDef.type = b2_dynamicBody;
    
    // can have the point where ever we want
    
	bodyDef.position = [CTUtility toMeters:aPoint];
	bodyDef.userData = sprite;
    
    //Define a box shape and assign it to the body fixture 
	b2CircleShape dynamicBox; 
	CGFloat radius = ((width(sprite)/PTM_RATIO) * 0.5f); 
	dynamicBox.m_radius = radius;
	
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution = 0.0f;
	fixtureDef.density = 0.0f;
	
	b2Body* staticBody;
	staticBody = world->CreateBody(&bodyDef);
	staticBody->CreateFixture(&fixtureDef);
    [sprite setPhysicsBody:staticBody];
    [sprite setWorld:world];
    return sprite;
}

@end
