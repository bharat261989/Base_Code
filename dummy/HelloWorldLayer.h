//
//  HelloWorldLayer.h
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright Exponere Entertainment 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "CTUtility.h"
#import "PhysicsSpritee.h"
#import "CTconveyor.h"
#import "ObjectCreator.h"
#import "CTCatapultt.h"

#import "MyContactListener.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	b2World* world;					// strong ref
    CTCatapult* catapult;
    CCSprite* gear1;
    CTCatapult* catapult2;
    b2RevoluteJointDef jd2;
    b2Joint *rev2_joint;
    MyContactListener *_contactListener;
    b2Fixture *_bottomFixture;
    b2Fixture *dest;
    b2Fixture *catFixture;
    b2Fixture *_ballFixture;
    b2Fixture *Fixture;
    b2Body* staticBody;
    b2Body* catstaticBody;
    b2Fixture *_bottomFixture6;
    b2Fixture *_bottomFixture3;
    b2Fixture *_bottomFixture4;
    b2Body* staticBody6;
    b2Body* staticBody3;
    b2Body* staticBody4;
    Ctconveyor* conveyor;
    int ballcount;
    

}
@end

