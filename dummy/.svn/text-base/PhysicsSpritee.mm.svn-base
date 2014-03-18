//
//  PhysicsSpritee.m
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright 2012 Exponere Entertainment. All rights reserved.
//

#import "PhysicsSpritee.h"

#import "Constants.h"
#pragma mark - PhysicsSpritee
@implementation PhysicsSpritee

-(void) setPhysicsBody:(b2Body *)body
{
	body_ = body;
}


-(b2Body *) getPhysicsBody
{
	return body_;
}

-(void ) createphysics:(PhysicsSpritee *)spt
{
    sp=spt;
    b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
    
    // can have the point where ever we want
    
	bodyDef.position = [CTUtility toMeters:ccp(viewportSize.width - 750 , 560)];
	bodyDef.userData = sp;
    bodyDef.fixedRotation = true;
    
    //Define a box shape and assign it to the body fixture
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(sp.contentSize.width/PTM_RATIO/2,
                        sp.contentSize.height/PTM_RATIO/20);
	//b2CircleShape dynamicBox;
	//CGFloat radius = ((width(sprite)/PTM_RATIO) * 0.5f);
	//dynamicBox.m_radius = radius;
	
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution = 0.0f;
	fixtureDef.density = 1.0f;
	
	
	body_ = world->CreateBody(&bodyDef);
    _myFixture = body_->CreateFixture(&fixtureDef);
	body_->CreateFixture(&fixtureDef);
	
}
-(void) setWorld:(b2World*)aWorld {
    world = aWorld;
}

-(void) settype:(int)inte {
    type = inte;
}

// this method will only get called if the sprite is batched.
// return YES if the physics values (angles, position ) changed
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	b2Vec2 pos  = body_->GetPosition();
	
	float x = pos.x * PTM_RATIO;
	float y = pos.y * PTM_RATIO;
	
	if ( !1 ) {
		x += _anchorPointInPoints.x;
		y += _anchorPointInPoints.y;
	}
	
	// Make matrix
	float radians = body_->GetAngle();
	float c = cosf(radians);
	float s = sinf(radians);
	
	if( ! CGPointEqualToPoint(_anchorPointInPoints, CGPointZero) ){
		x += c*-_anchorPointInPoints.x + -s*-_anchorPointInPoints.y;
		y += s*-_anchorPointInPoints.x + c*-_anchorPointInPoints.y;
	}
	
	// Rot, Translate Matrix
	_transform = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );	
	
	return _transform;
}

-(void) dealloc
{
	// 
	[super dealloc];
}

@end
