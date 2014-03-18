//
//  Ctconveyor.m
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright 2012 Exponere Entertainment. All rights reserved.
//

#import "Ctconveyor.h"
#define CANNON @"belt.png"
#define CANNON_BASE @"gear.png"
#define ARROW_OUTER @"arrow_outer.png"
#define ARROW_INNER @"gear.png"
#define PLUME_IMAGE @"plume.png"


#import "Constants.h"
#pragma mark - Ctconveyor
@implementation Ctconveyor


-(id) init:(int)angle
{
	if( (self=[super init])) {
        /*
         rotion vals are as follows:
         * North: -90
         * South: -270 | 90 but never these two values
         * East: 0
         * West: -180
         */
        
        speed=4;
		l_r_angle = angle;
		belt = [CCSprite spriteWithFile:CANNON];
		[self addChild:belt z:0 tag:1];
		//right.anchorPoint = ccp(0.9,0.2);
        
        left = [CCSprite spriteWithFile:CANNON_BASE];
		//[self addChild:cannon_base z:0 tag:4];
		left.position =  ccp(40,height(belt)/2-30);
		
        right = [CCSprite spriteWithFile:ARROW_INNER];
        right.position = ccp(width(belt)-40,height(belt)/2-30);
        left.scale = 0.5f;
        right.scale = 0.5f;
        CCRotateBy *rotateAction;
        CCRotateBy *rotateAction2;
        if(angle == 1){
        rotateAction=[CCRotateBy actionWithDuration:100 angle:-5000];
        rotateAction2=[CCRotateBy actionWithDuration:100 angle:-5000];
        }else{
            rotateAction=[CCRotateBy actionWithDuration:100 angle:5000];
            rotateAction2=[CCRotateBy actionWithDuration:100 angle:5000];
        }
        [right runAction:rotateAction];
        [left runAction:rotateAction2];
        
        [belt addChild:right];
         [belt addChild:left];
        
	}
	return self;
}

-(void) setPhysicsBody:(b2Body *)body
{
	body_ = body;
}


-(void) set_contactListener:(MyContactListener *)listner
{
	_contactListener = listner;
}

-(void) iscontact:(b2Fixture *)fixture cannonBallBody:(b2Body *)cannonBallBody{
    
    std::vector<MyContact>::iterator pos;
    pos=_contactListener->_contacts.begin();
   // NSLog(@"Ball hit bottom funv !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    for (pos=_contactListener->_contacts.begin();
         pos != _contactListener->_contacts.end(); ++pos) {
        MyContact contact = *pos;
        // NSLog(@"Ball hit bottom!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        if ((contact.fixtureA == _myFixture && contact.fixtureB == fixture) ||
            (contact.fixtureA == fixture && contact.fixtureB == _myFixture)) {
            NSLog(@"Ball hit bottom!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            //CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
            // [[CCDirector sharedDirector] replaceScene:gameOverScene];
            if(l_r_angle == 0)
            cannonBallBody->SetLinearVelocity(b2Vec2(speed,0
                                                     ));
            else
                cannonBallBody->SetLinearVelocity(b2Vec2(-speed,0
                                                         ));
            // cannonBall.tag= 200;
            
        }
    }
}

-(void) myccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    //UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
     NSLog(@"%f - x , %f - Y",pos.y,location.x);
    
    
    if (CGRectContainsPoint( CGRectMake(pos.x-width(belt)/2+30,pos.y-40, 50,50), location)) {
        if(l_r_angle == 0){
        if(speed>3)
            speed--;
        }else{
        if(speed<14)
            speed++;
        }
        
        //some code to destroy ur enemy here
        NSLog(@"CATApult positionyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        
    }if (CGRectContainsPoint( CGRectMake(pos.x+width(belt)/2-60,pos.y-40, 50,50), location)) {
        if(l_r_angle == 0){
        if(speed<14)
            speed++;
        }else{
        if(speed>3)
            speed--;
        }
        //some code to destroy ur enemy here
        NSLog(@"CATApult positionyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        
    }
    }


-(b2Body *) getPhysicsBody
{
	return body_;
}

-(b2Fixture *) getb2Fixture
{
	return _myFixture;
}


-(void ) createphysics:(Ctconveyor *)spt x_co:(float)x y_co:(float)y angle:(int)angle 
{
    
    pos.x=x;
    pos.y=y;
    sp=spt;
    b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
    
    
    // can have the point where ever we want
    
	bodyDef.position = [CTUtility toMeters:ccp(x , y)];
	bodyDef.userData = belt;
    bodyDef.fixedRotation = true;
    
    //Define a box shape and assign it to the body fixture
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(belt.contentSize.width/PTM_RATIO/3,
                        belt.contentSize.height/PTM_RATIO/20);
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
