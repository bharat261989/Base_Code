//
//  Catapult.h
//  Catapult
//
//  Created by Muhammed Ali Khan on 6/28/11.
//  Copyright 2011 Exponere Entertainment. All rights reserved.
//
#import "PhysicsSpritee.h"
#import "MyContactListener.h"
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

@interface CTCatapult : CCSprite {
	@public CCSprite* cannon;
	CCProgressTimer* arrow;
    CCSprite* arrow_base;
	float maxRotation;
    CCSprite* cannon_base;
	float minRotation;
    b2World* world; //weak ref
 b2Fixture *_myFixture;
    CGPoint pos;
	CGPoint dropPoint;
    float maxForce, minForce;
        MyContactListener *_contactListener;
    int mytouch;
    
}
-(id) init:(float)x y_co:(float)y setWorld:(b2World*)aWorld;
-(CGPoint)getPoint;
-(void)setTapPoint:(CGPoint)loc;
-(void) set_contactListener:(MyContactListener *)listner;
-(void)registerDropPoint:(CGPoint)loc;
-(void) myccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(int) iscontacts:(b2Fixture *)fixture cannonBallBody:(b2Body *)cannonBallBody;
-(void)releaseHolder;
-(float) getForce;
-(void)setTouch:(int)t;
-(b2Vec2) getVectorVeloctiy:(CGPoint) loc;
-(float) getCocosAngle;
-(float) getBox2dAngle;
-(CGPoint) getFirePoint;
-(void) setMinForce:(float)val;
-(int)getTouch;
-(void)setMaxForce:(float)val;
@end
