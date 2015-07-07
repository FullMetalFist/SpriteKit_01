//
//  GameScene.m
//  SpriteKit_01
//
//  Created by Michael Vilabrera on 7/6/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

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

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
