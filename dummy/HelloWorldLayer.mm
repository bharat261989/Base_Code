//
//  HelloWorldLayer.mm
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright Exponere Entertainment 2012. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"
#import "HelloWorldLayerm.h"

#import "Constants.h"

@interface HelloWorldLayer (Private)
-(void) initPhysics;
-(void) createScene;
-(void) launchProjectileWithVelocity:(b2Vec2)aVelocity;
-(void) drawPathForCurrentTurretState:(b2Vec2)startVelocity;
-(b2Vec2) getTrajectoryPoint:(b2Vec2) startingPosition andStartVelocity:(b2Vec2) startingVelocity andSteps: (float)n;
@end

#pragma mark - HelloWorldLayer
@implementation HelloWorldLayer

-(id) init
{
	if( (self=[super init])) {

		self.isTouchEnabled = YES;
		
		// init physics
		[self initPhysics];
		[self createScene];
        [self scheduleUpdate];
	}
	return self;
}
-(void) dealloc
{
    RELEASE_OBJECT(catapult);
    
	delete world;
	world = NULL;
    staticBody = NULL;
    delete _contactListener;
	[super dealloc];
}
Ctconveyor* sprite,*sprite6,*sprite3;

-(void) createScene {
    CCSprite* background = [CCSprite spriteWithFile:@"background.png"];
    background.scale=1.9f;
    [self addChild:background];
    background.position = ccp(width(background)/2,height(background)/2);
    

    
    _contactListener = new MyContactListener();
    world->SetContactListener(_contactListener);

   
    [self createConveyor];
    
   
    
 
   [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    [ObjectCreator setWorld:world];
    [ObjectCreator setParentLayer:self];
    
    
    
    
    
    
    catapult = [[CTCatapult alloc] init:viewportSize.width - 550 y_co:200 setWorld:world];
	[self addChild:catapult z:2 tag:2];
     [catapult set_contactListener:_contactListener];
    [catapult setMaxForce:200];
    [catapult setMinForce:0];    
	[catapult setPosition:ccp(viewportSize.width - 550, 200)];

    CGPoint kick;
    kick.x = viewportSize.width - 550;
    kick.y = 700;
    NSLog(@" Creating Ball 1\n");
    cannonBall = [ObjectCreator
                                 createFreeCircularBodyWithFile:@"cannon_ball_black.png"
                                 atPoint:kick];
    cannonBall.tag=200;
    b2CircleShape dynamicBoxx;
	CGFloat radiusx = ((width(cannonBall)/PTM_RATIO) * 0.5f);
	dynamicBoxx.m_radius = radiusx;
   // count = 1;
    
    b2FixtureDef fixtureDefx;
	fixtureDefx.shape = &dynamicBoxx;
	fixtureDefx.friction = 1.0f;
	fixtureDefx.restitution = 0.0f;
	fixtureDefx.density = 1.0f;
    
    
    cannonBallBody = [cannonBall getPhysicsBody];
    _ballFixture = cannonBallBody->CreateFixture(&fixtureDefx);
    
    ballcount=1;
    
    [self createMenu];
    
    [self createdest];
    [self createsrc];
    
}
NSMutableArray *temp = [[NSMutableArray alloc] init];


-(void) createConveyor{
    int i;
    
   // for (i = 0; i < 3; i++){
    
    Ctconveyor *conveyor = [[Ctconveyor alloc] init:0];
    [self addChild:conveyor z:2];
    [conveyor setPosition:ccp(viewportSize.width - 700, 500)];    [conveyor setWorld:world];
    [conveyor createphysics:conveyor x_co:viewportSize.width - 700
                       y_co:500 angle:70];
    [conveyor set_contactListener:_contactListener];
    [temp addObject:conveyor];
    
    
    conveyor = [[Ctconveyor alloc] init:1];
    [self addChild:conveyor z:2];
    [conveyor setPosition:ccp(viewportSize.width - 150 , 300)];    [conveyor setWorld:world];
    [conveyor createphysics:conveyor x_co:viewportSize.width - 150
                       y_co:300 angle:70];
    [conveyor set_contactListener:_contactListener];
    [temp addObject:conveyor];
    
    
    conveyor = [[Ctconveyor alloc] init:0];
    [self addChild:conveyor z:2];
    [conveyor setPosition:ccp(viewportSize.width - 350 , 400)];    [conveyor setWorld:world];
    [conveyor createphysics:conveyor x_co:viewportSize.width - 350
                       y_co:400 angle:70];
    [conveyor set_contactListener:_contactListener];
    [temp addObject:conveyor];
    
//}
}

CCSprite *ship1,*ship2,*ship,*cannon,*ship3,*ship4;
int count = 1;
int ball_create = 0;
float m =1.0f;
int val = 4;
int val2 = 4;

-(void) gameLoop {
    if(m > 360)
        m =1.0f;
	[sprite setRotation:m++];
    sprite.rotation = m;
   // NSLog(@"CATApult position position position");
    
   
    int i=0;
    
    for (i = 0; i < 3; i++){
        
        [temp[i] iscontact:_ballFixture cannonBallBody:cannonBallBody];
    }
    
    int did_contact=[catapult iscontacts:_ballFixture cannonBallBody:cannonBallBody];
    if(did_contact == 0){
        world->DestroyBody(cannonBallBody);
         ballcount=0;
        CCSprite* dot = (CCSprite *)[self getChildByTag:200];
        while (dot) {
            [dot removeFromParentAndCleanup:YES];
            dot = (CCSprite *)[self getChildByTag:200];
            NSLog(@" Deleting balls \n");
        }
    }
    
    
    
//    std::vector<MyContact>::iterator pos;
//    pos=_contactListener->_contacts.begin();
//    // NSLog(@"Ball hit bottom funv !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//    for (pos=_contactListener->_contacts.begin();
//         pos != _contactListener->_contacts.end(); ++pos) {
//        if(ballcount == 1){
//            world->DestroyBody(cannonBallBody);
//            ballcount=0;
//            CCSprite* dot = (CCSprite *)[self getChildByTag:200];
//            while (dot) {
//                [dot removeFromParentAndCleanup:YES];
//                dot = (CCSprite *)[self getChildByTag:200];
//                NSLog(@" Deleting balls \n");
//            }
//            
//            [self createMenu];
//            break;}
//        
//    }

    
   
}
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayerm *layer = [HelloWorldLayerm node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void) createMenu
{
	// Default font size will be 22 points.
	[CCMenuItemFont setFontSize:22];
	
	// Reset Button
	// Reset Button
	CCMenuItemLabel *reset = [CCMenuItemFont itemFromString:@"Reset" block:^(id sender){
        if(ballcount == 1){
        world->DestroyBody(cannonBallBody);
        ballcount=0;
        CCSprite* dot = (CCSprite *)[self getChildByTag:200];
        while (dot) {
            [dot removeFromParentAndCleanup:YES];
            dot = (CCSprite *)[self getChildByTag:200];
            NSLog(@" Deleting balls \n");
        }
        }

        
		//[[CCDirector sharedDirector] replaceScene: [HelloWorldLayerm scene]];
	}];
    
	// to avoid a retain-cycle with the menuitem and blocks
	
    
	// Achievement Menu Item using blocks

	
	CCMenu *menu = [CCMenu menuWithItems: reset, nil];
	
	[menu alignItemsVertically];
	
	CGSize size = [[CCDirector sharedDirector] winSize];
	[menu setPosition:ccp( size.width/2, size.height/2)];
	
	
	[self addChild: menu];
}

-(void) launchProjectileWithVelocity:(b2Vec2)aVelocity
{    
	
    NSLog(@"CATApult position");
    NSLog(@" %f   %f",catapult.position.x,catapult.position.y);
    CGPoint kick =[catapult getPoint];
    
    NSLog(@" VelocityA= %f , VelocityB = %f", aVelocity.x,aVelocity.y);
    NSLog(@" Creating Ball 2 \n");
    cannonBall = [ObjectCreator
                                 createFreeCircularBodyWithFile:@"cannon_ball_black.png" 
                                 atPoint:kick];
    cannonBall.tag= 200;
    ballcount=1;
    
    b2CircleShape dynamicBox;
	CGFloat radius = ((width(cannonBall)/PTM_RATIO) * 0.5f);
	dynamicBox.m_radius = radius;
    
    b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution = 0.0f;
	fixtureDef.density = 1.0f;
    
    
    cannonBallBody = [cannonBall getPhysicsBody];
    _ballFixture = cannonBallBody->CreateFixture(&fixtureDef);
    cannonBallBody->SetLinearVelocity(aVelocity);
}

PhysicsSpritee* cannonBall;
b2Body* cannonBallBody;

-(void) launchProjectileWithVelocityy:(b2Vec2)aVelocity
{
	NSLog(@"CATApult position");    sprite.rotation = aVelocity.x*100;
}

-(void) initPhysics
{
    world = new b2World(b2Vec2(0.0,-9.8));
	world->SetAllowSleeping(false);
	world->SetContinuousPhysics(true);
	
    // Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0,0); // bottom-left corner
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	b2EdgeShape groundBox;		
	
	// bottom	
	groundBox.Set(b2Vec2(0,0), 
                  b2Vec2(viewportSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,viewportSize.height/PTM_RATIO), 
                  b2Vec2(viewportSize.width/PTM_RATIO,viewportSize.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,viewportSize.height/PTM_RATIO), 
                  b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(viewportSize.width/PTM_RATIO,viewportSize.height/PTM_RATIO), 
                  b2Vec2(viewportSize.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}


-(void) initPhysicsdel
{
 
    NSLog(@" Deleting balls \n");
    CCSprite* dot = (CCSprite *)[self getChildByTag:200];
    while (dot) {
        [dot removeFromParentAndCleanup:YES];
        dot = (CCSprite *)[self getChildByTag:200];
        NSLog(@" Deleting balls \n");
    }
    
    CGPoint kick;
    kick.x = viewportSize.width - 50;
    kick.y = 700;
    cannonBall = [ObjectCreator
                  createFreeCircularBodyWithFile:@"cannon_ball_black.png"
                  atPoint:kick];
    cannonBall.tag=200;
    b2CircleShape dynamicBoxx;
	CGFloat radiusx = ((width(cannonBall)/PTM_RATIO) * 0.5f);
	dynamicBoxx.m_radius = radiusx;
    // count = 1;
    
    b2FixtureDef fixtureDefx;
	fixtureDefx.shape = &dynamicBoxx;
	fixtureDefx.friction = 1.0f;
	fixtureDefx.restitution = 0.0f;
	fixtureDefx.density = 1.0f;
    
    
    cannonBallBody = [cannonBall getPhysicsBody];
    _ballFixture = cannonBallBody->CreateFixture(&fixtureDefx);
    count =1;
   }


-(void) createdest
{
    Ctconveyor* sprite;
    sprite = [Ctconveyor spriteWithFile:@"funnel.png"];
    sprite.tag=12;
    
    sprite.rotation = 90;
    
    [self addChild:sprite z:2];
    
    b2BodyDef bodyDef;
	bodyDef.type = b2_staticBody;
    
    
	bodyDef.position = [CTUtility toMeters:ccp(viewportSize.width - 1000 , 10)];
	bodyDef.userData = sprite;
    bodyDef.fixedRotation = true;
    
    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(sprite.contentSize.width/PTM_RATIO/4,
                        sprite.contentSize.height/PTM_RATIO/2);
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;
	fixtureDef.friction = 1.0f;
	fixtureDef.restitution = 0.0f;
	fixtureDef.density = 1.0f;
	
	
	staticBody = world->CreateBody(&bodyDef);
    dest = staticBody->CreateFixture(&fixtureDef);
	staticBody->CreateFixture(&fixtureDef);
    [sprite setPhysicsBody:staticBody];
    [sprite setWorld:world];
    [sprite setRotation:90.0f];
    
}


-(void) createsrc
{
    CCSprite* sprite;
    sprite = [CCSprite spriteWithFile:@"funnel.png"];
    sprite.tag=12;
     [sprite setPosition:ccp(viewportSize.width - 550, 720)];
   // sprite.rotation = 90;
    
    [self addChild:sprite z:2];
    
  
    
}


-(void) update: (ccTime) dt
{
	
	int32 velocityIterations = 8;
	int32 positionIterations = 2;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);	
}
-(void) drawPathForCurrentTurretState:(b2Vec2)startVelocity {
    
    //Step 1: remove previous path
    CCSprite* dot = (CCSprite *)[self getChildByTag:555];
    while (dot) {
        [dot removeFromParentAndCleanup:YES];
        dot = (CCSprite *)[self getChildByTag:555];
    }

    //Step 2: draw new path
    for (int i = 1; i <= 60; i++) { 
        
        //get the postion at this iteration
        b2Vec2 trajectoryPosition = [self getTrajectoryPoint:[CTUtility toMeters:catapult.position] andStartVelocity:startVelocity andSteps:i*3];        
        
        //create the point
        CCSprite* dot = [CCSprite spriteWithFile:@"explode4.png"];
        dot.scale = 0.5f;
        
        //fade out the path
        CGFloat ratio = (float)i/60;
        [dot setOpacity:255 - ratio*200];
        
        //add the point to the stage
        [self addChild:dot z:0 tag:555];
        
        //position it
        dot.position = [CTUtility toPixels:trajectoryPosition];
    }
}


-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //pass the tap coordinate to the catapult so that it can adjust its arrow - This is the first position, from where all the preceding calculations will take place.
    [catapult registerDropPoint:[CTUtility getNormalizedLocation:touches]];
    
    
    int i=0;
    
    for (i = 0; i < 3; i++){
        
        [temp[i] myccTouchesBegan:touches withEvent:event];
    }
    
    [catapult myccTouchesBegan:touches withEvent:event];
    

    
    
    
    
    //draw the path for the current velocity and start point
    //[self drawPathForCurrentTurretState:[catapult getVectorVeloctiy:[CTUtility getNormalizedLocation:touches]]];
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //pass the tap coordinate to the catapult so that it can adjust its arrow
    if([catapult getTouch] == 0 &&  ballcount==0)
    [catapult setTapPoint:[CTUtility getNormalizedLocation:touches]];
    //[self launchProjectileWithVelocityy:[catapult getVectorVeloctiy:[CTUtility getNormalizedLocation:touches]]];

    //draw the path for the current velocity and start point
   if([catapult getTouch] == 0 &&  ballcount==0)
    [self drawPathForCurrentTurretState:[catapult getVectorVeloctiy:[CTUtility getNormalizedLocation:touches]]];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //pass the tap coordinate to the catapult so that it can adjust its arrow
    //[self drawPathForCurrentTurretState:[catapult getVectorVeloctiy:[CTUtility getNormalizedLocation:touches]]];
    
    //removes the arrow and prepares for the next shot
	//[catapult releaseHolder];
    CCSprite* dot = (CCSprite *)[self getChildByTag:555];
    while (dot) {
        [dot removeFromParentAndCleanup:YES];
        dot = (CCSprite *)[self getChildByTag:555];
    }
    
    
   
    
    //draw the path for the current velocity and start point
    if([catapult getTouch] == 0 &&  ballcount==0){
    [self launchProjectileWithVelocity:[catapult getVectorVeloctiy:[CTUtility getNormalizedLocation:touches]]];
        [catapult setTouch:1];
    }
  
}

//calculates the point where the object will be after nth iterations for a given start point and start velocity
-(b2Vec2) getTrajectoryPoint:(b2Vec2) startingPosition andStartVelocity:(b2Vec2) startingVelocity andSteps: (float)n
{
    //velocity and gravity are given per second but we want time step values here
    // seconds per time step (at 60fps)
    float t = 1 / 60.0f; 
    
    // m/s
    b2Vec2 stepVelocity = t * startingVelocity; 
    
    // m/s/s
    b2Vec2 stepGravity = t * t * world->GetGravity(); 
    
    return startingPosition + n * stepVelocity + 0.5f * (n*n+n) * stepGravity;
}



@end
