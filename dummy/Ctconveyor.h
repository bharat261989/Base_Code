//
//  PhysicsSprite.h
//  SpaceDemo
//
//  Created by Muhammed Ali Khan on 3/10/12.
//  Copyright 2012 Exponere Entertainment. All rights reserved.
//


#import "PhysicsSpritee.h"

#import "MyContactListener.h"

@interface Ctconveyor : CCSprite
{
    CCSprite *belt;
    CCSprite *right;
     CGPoint pos;
    CCSprite *left;
    b2World* world; //weak ref
    int type;
	b2Body *body_;
    b2Fixture *_myFixture;
    MyContactListener *_contactListener;
	Ctconveyor *sp;// strong ref
    int l_r_angle;
    int speed;
}
-(id) init:(int)angle;
-(void) setPhysicsBody:(b2Body*)body;
-(b2Body *) getPhysicsBody;
-(void) setWorld:(b2World*)aWorld;
-(void ) createphysics:(Ctconveyor *)spt x_co:(float)x y_co:(float)y angle:(int)angle;
-(b2Fixture *) getb2Fixture;
-(void) iscontact:(b2Fixture *)fixture cannonBallBody:(b2Body *)cannonBallBody;
-(void) set_contactListener:(MyContactListener *)listner;
-(void) myccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
@end
