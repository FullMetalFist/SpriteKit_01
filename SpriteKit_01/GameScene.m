//
//  GameScene.m
//  SpriteKit_01
//
//  Created by Michael Vilabrera on 7/6/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "GameScene.h"

@interface GameScene() <SKPhysicsContactDelegate>

@property (nonatomic) SKSpriteNode *paddle;

@end

static const uint32_t ballCategory      = 1;    // 00000000000000000000000000000001
static const uint32_t brickCategory     = 2;    // 00000000000000000000000000000010
static const uint32_t paddleCategory    = 4;    // 00000000000000000000000000000100
static const uint32_t edgeCategory      = 8;    // 00000000000000000000000000001000

/*
 or, we may use bitwise operators
 static const uint32_t ballCategory      = 0x1;         // 00000000000000000000000000000001
 static const uint32_t brickCategory     = 0x1 << 1;    // 00000000000000000000000000000010
 static const uint32_t paddleCategory    = 0x1 << 2;    // 00000000000000000000000000000100
 static const uint32_t edgeCategory      = 0x1 << 3;    // 00000000000000000000000000001000
 */

@implementation GameScene

-(void)didBeginContact:(SKPhysicsContact *)contact {
//    if (contact.bodyA.categoryBitMask == brickCategory) {
//        NSLog(@"Brick Boing");
//        [contact.bodyA.node removeFromParent];
//    }
    
    // create placeholder reference for the "non ball" object
    SKPhysicsBody *notTheBall;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheBall = contact.bodyB;
    } else {
        notTheBall = contact.bodyA;
    }
    
    if (notTheBall.categoryBitMask == brickCategory) {
        NSLog(@"Bye brick!");
        [notTheBall.node removeFromParent];
    }
    
    if (notTheBall.categoryBitMask == paddleCategory) {
        NSLog(@"Play boing sound");
    }
}

- (void)addBall {
    // new sprite from the ball
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    
    CGPoint ballPoint = CGPointMake(self.size.width / 2, self.size.height/2);
    ball.position = ballPoint;
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1;
    ball.physicsBody.categoryBitMask = ballCategory;
    
    ball.physicsBody.contactTestBitMask = brickCategory | paddleCategory;
//    ball.physicsBody.collisionBitMask = edgeCategory | brickCategory;   // only collides with the edge and brick
    
    // add to screen
    [self addChild:ball];
    
    // create vector
    CGVector simpleVector = CGVectorMake(10, 10);
    
    // apply vector to ball
    [ball.physicsBody applyImpulse:simpleVector];
}

- (void)addBricks {
    for (int i = 0; i < 8; i++) {
        SKSpriteNode *brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
        
        // add a static body
        brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
        brick.physicsBody.dynamic = NO;
        brick.physicsBody.categoryBitMask = brickCategory;
        
        int xPos = self.size.width / 5 * (i+1);
        int yPos = self.size.height - 50;
        brick.position = CGPointMake(xPos, yPos);
        
        [self addChild:brick];
    }
}

- (void)addPlayer {
    // create paddle
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    // position it
    self.paddle.position = CGPointMake(self.size.width/2, 100);
    // add a physics body
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    // make paddle static
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddleCategory;
    // add to scene
    [self addChild:self.paddle];
}

/*
 
 NOTES:
 old tutorials use the method -(id)initWithSize:(CGSize)size
 new ones may take the same code in -(void)didMoveToView:(SKView *)view
 
 */

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor whiteColor];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = edgeCategory;
    
    // change gravity settings
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;   // didBeginContact: & didEndContact:
    
    [self addBall];
    [self addPlayer];
    [self addBricks];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint nextPosition = CGPointMake(location.x, 100);
        self.paddle.position = nextPosition;
        // stop paddle from going too far
        if (nextPosition.x < self.paddle.size.width / 2) {
            nextPosition.x = self.paddle.size.width / 2;
        }
        if (nextPosition.x > self.size.width - (self.paddle.size.width / 2)) {
            nextPosition.x = self.size.width - (self.paddle.size.width / 2);
        }
    }
}

@end
