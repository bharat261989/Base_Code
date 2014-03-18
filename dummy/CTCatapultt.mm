//
//  Catapult.m
//  Catapult
//
//  Created by Muhammed Ali Khan on 6/28/11.
//  Copyright 2011 Exponere Entertainment. All rights reserved.
//

#import "CTCatapultt.h"
#import "Constants.h"
#define CANNON @"cannon_new.png"
#define CANNON_BASE @"gear.png"
#define ARROW_OUTER @"arrow_outer.png"
#define ARROW_INNER @"arrow_inner.png"
#define PLUME_IMAGE @"plume.png"

@implementation CTCatapult

-(id) init:(float)x y_co:(float)y setWorld:(b2World*)aWorld
{
	if( (self=[super init])) {
        /*
         rotion vals are as follows:
         * North: -90
         * South: -270 | 90 but never these two values
         * East: 0         
         * West: -180
         */
        mytouch=1;
        world = aWorld;
        pos.x=x;
        pos.y=y;
		maxRotation = 0;
		minRotation = -180;
		
		cannon = [CCSprite spriteWithFile:CANNON];
		[self addChild:cannon z:0 tag:1];
		cannon.anchorPoint = ccp(0.9,0.6);
        
        cannon_base = [CCSprite spriteWithFile:CANNON_BASE];
        cannon_base.scale=0.0f;
		[self addChild:cannon_base z:0 tag:4];
		cannon_base.position = ccp(10,10);
		
        arrow_base = [CCSprite spriteWithFile:ARROW_INNER];
        arrow_base.position = ccp(width(cannon) + width(arrow_base)/2 - 15,height(cannon)/2 + 3);
        
        arrow = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:ARROW_INNER]];
        arrow.type = kCCProgressTimerTypeBar;
        arrow.midpoint = ccp(0,0.5);
		arrow.position = ccp(width(cannon) + width(arrow)/2 - 15,height(cannon)/2 + 3);
		arrow.percentage = 50;
        
        [cannon addChild:arrow_base];
        [cannon addChild:arrow];
        
        
        b2BodyDef bodyDef2;
        bodyDef2.type = b2_staticBody;
        
        ///dummy
        
        // can have the point where ever we want
        
        bodyDef2.position = [CTUtility toMeters:ccp(viewportSize.width - 550, 175)];
        bodyDef2.userData = cannon_base;
        
        //Define a box shape and assign it to the body fixture
        b2PolygonShape dynamicBox2;
        dynamicBox2.SetAsBox(cannon.contentSize.width/PTM_RATIO/10,
                             cannon.contentSize.height/PTM_RATIO/10);
        //b2CircleShape dynamicBox;
        //CGFloat radius = ((width(sprite)/PTM_RATIO) * 0.5f);
        //dynamicBox.m_radius = radius;
        
        b2FixtureDef fixtureDef2;
        fixtureDef2.shape = &dynamicBox2;
        fixtureDef2.friction = 1.0f;
        fixtureDef2.restitution = 0.0f;
        fixtureDef2.density = 1.0f;
        
        
        _myFixture = world->CreateBody(&bodyDef2)->CreateFixture(&fixtureDef2);
	}
	return self;
}

-(void) setWorld:(b2World*)aWorld {
    world = aWorld;
}

-(void) set_contactListener:(MyContactListener *)listner
{
	_contactListener = listner;
}

-(int) iscontacts:(b2Fixture *)fixture cannonBallBody:(b2Body *)cannonBallBody{
    
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
            return 0;
            // cannonBall.tag= 200;
            
        }
    }
    return 1;
}


-(void) myccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    //UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    NSLog(@"%f - catttttttttttt , %f - Y",cannon_base.position.y,location.x);
    
    
    if (CGRectContainsPoint( CGRectMake(pos.x-width(cannon_base)/2+30,pos.y-40, 50,50), location)) {
        
        //some code to destroy ur enemy here
        mytouch=0;
        NSLog(@"CATApult positionyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
        
    }
}

-(void)registerDropPoint:(CGPoint)loc
{
    //[arrow_base runAction:[CCFadeIn actionWithDuration:0.2]];
    //[arrow runAction:[CCFadeIn actionWithDuration:0.2]];
	dropPoint = loc;
    NSLog(@" Dropppppppppppppppppppppppp Point");
    NSLog(@" DX = %f , DY = %f", loc.x,loc.y);
    
    cannon.rotation = -90;	
}

-(CGPoint)getPoint
{
    return pos;
}
-(int)getTouch
{
    return mytouch;
}
-(void)setTouch:(int)t
{
    mytouch = t;
}
-(b2Vec2) getVectorVeloctiy:(CGPoint) loc {
    
    
    float posX = dropPoint.x - loc.x;
	float posY = dropPoint.y - loc.y;
    
    posX /= 8;
    posY /= 8;
    
    NSLog(@" X = %f , Y = %f", loc.x,loc.y);
    
    
    
    return b2Vec2(posX,posY);
}
-(void)setTapPoint:(CGPoint)loc
{    
    float posX = dropPoint.x - loc.x;
	float posY = dropPoint.y - loc.y;
    
    
    //calculate rotation
	float rotationVal = (atan2f(posX, posY) * 180 / M_PI) - 90;
    if (rotationVal < minRotation) {
        rotationVal = minRotation;
    } else if (rotationVal > maxRotation) {
        rotationVal = maxRotation;
    }
    cannon.rotation = rotationVal;
    
    //calculate force
	float forceBarLength = sqrtf(powf(posX,2) + powf(posY, 2));	
    float val = (float)((forceBarLength-minForce)/(maxForce-minForce))*100;
    
    if (val > 100) {
        val = 100;
    } else if (val < 10){
        val = 10;
    }
    
    //arrow.percentage = val;
}
-(void)setMaxForce:(float)val
{
    maxForce = val;
}
-(void) setMinForce:(float)val
{
    minForce = val;
}
-(float) getForce 
{    
	NSLog(@"Force is %f\n\n\n",arrow.percentage/7);
    return arrow.percentage/7;
}
-(float) getCocosAngle 
{
	return cannon.rotation;
}
-(float) getBox2dAngle 
{
	return CC_DEGREES_TO_RADIANS(cannon.rotation * -1);
}
-(CGPoint)getFirePoint
{
    NSLog(@"HURRAAAAAAAAy");
	return ccp(posx(self) + posx(cannon), posy(self) + posy(cannon));
}


-(void) releaseHolder
{
    arrow.opacity = 2;
    arrow_base.opacity = 6;
    
    CCSprite* plume = [CCSprite spriteWithFile:PLUME_IMAGE];
    [cannon addChild:plume];
    plume.opacity = 0;
    plume.position = ccp(width(cannon) + width(plume)/2 - 15,height(cannon)/2 + 3);
    [plume runAction:[CCMoveTo actionWithDuration:0.15 position:ccp(width(cannon) + width(plume)/2,height(cannon)/2 + 3)]];
    [plume runAction:[CCSequence actions:
                      [CCFadeIn actionWithDuration:0.15],
                      [CCDelayTime actionWithDuration:0.2],
                      [CCFadeOut actionWithDuration:0.15],
                      [CCCallFuncND actionWithTarget:plume selector:@selector(removeFromParentAndCleanup:) data:(void *)YES],
                      nil]
     ];
}
-(void)resetLocation
{
	
}
-(void) dealloc
{	
	[super dealloc];
}
@end
