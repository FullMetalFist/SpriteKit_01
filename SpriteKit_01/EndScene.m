//
//  EndScene.m
//  SpriteKit_01
//
//  Created by Michael Vilabrera on 7/13/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

#import "EndScene.h"
#import "GameScene.h"

@interface EndScene()

@property (nonatomic) SKAction *gameOverSFX;

@end

@implementation EndScene

- (void)didMoveToView:(SKView *)view {
    
    self.backgroundColor = [SKColor blackColor];
    
    self.gameOverSFX = [SKAction playSoundFileNamed:@"gameover.caf" waitForCompletion:NO];
    [self runAction:self.gameOverSFX];
    
    // this is viewable without tryAgain animation.
    // after animation, nothing is viewable
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    label.text = @"Game Over";
    label.fontColor = [SKColor whiteColor];
    label.fontSize = 44;
    label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:label];
    
    // second label
    SKLabelNode *tryAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    label.text = @"Tap to play again";
    label.fontColor = [SKColor whiteColor];
    label.fontSize = 24;
    label.position = CGPointMake(self.size.width/2, -50);
    
    SKAction *moveLabel = [SKAction moveToY:(self.size.height/2 - 44) duration:2.0];
    [tryAgain runAction:moveLabel];
    
    [self addChild:tryAgain];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    GameScene *gameScene = [GameScene sceneWithSize:self.size];
    [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.5]];
}

@end
