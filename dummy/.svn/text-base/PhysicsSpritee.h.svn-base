//
//  PhysicsSpritee.h
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright 2012 Exponere Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"

#import "CTUtility.h"

@interface PhysicsSpritee : CCSprite
{
    b2World* world; //weak ref
    int type;
	b2Body *body_;
    b2Fixture *_myFixture;
	PhysicsSpritee *sp;// strong ref
}
-(void) setPhysicsBody:(b2Body*)body;
-(b2Body *) getPhysicsBody;
-(void) setWorld:(b2World*)aWorld;
-(void ) createphysics:(PhysicsSpritee *)spt;
@end
