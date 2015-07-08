//
//  GameScene.m
//  SpriteKit_01
//
//  Created by Michael Vilabrera on 7/6/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

@property (nonatomic) SKSpriteNode *paddle;

@end

@implementation GameScene

- (void)addBall {
    // new sprite from the ball
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    
    CGPoint ballPoint = CGPointMake(self.size.width / 2, self.size.height/2);
    ball.position = ballPoint;
    
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1;
    
    // add to screen
    [self addChild:ball];
    
    // create vector
    CGVector simpleVector = CGVectorMake(20, 20);
    
    // apply vector to ball
    [ball.physicsBody applyImpulse:simpleVector];
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
    
    // change gravity settings
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    
    [self addBall];
    [self addPlayer];
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
