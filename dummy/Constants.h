


//memory macros
#define RELEASE_OBJECT(__POINTER) {if(__POINTER){[__POINTER release];__POINTER = nil;}}
#define RELEASE_ARRAY(__POINTER) {if(__POINTER){[__POINTER removeAllObjects];[__POINTER release];__POINTER = nil;}}

//helper macros
#define width(a) a.contentSize.width
#define height(a) a.contentSize.height
#define posy(a) a.position.y
#define posx(a) a.position.x
#define viewportSize [CCDirector sharedDirector].winSize


//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32
