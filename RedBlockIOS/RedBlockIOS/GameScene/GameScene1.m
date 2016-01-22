//
//  GameScene1.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene1.h"

@implementation GameScene1

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-8*GAME_TILE_WIDTH, 0);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -(9*GAME_TILE_WIDTH+2), 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH, (1.5-2*i)*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        
        SKAction *moveAction1 = [SKAction moveBy:CGVectorMake(9*GAME_TILE_WIDTH,0) duration:1.5f];
        SKAction *moveAction2 = [moveAction1 reversedAction];
        SKAction *sequenceAction = [SKAction sequence:[NSArray arrayWithObjects:moveAction1,moveAction2, nil]];
        SKAction *repeatAction = [SKAction repeatActionForever:sequenceAction];
        [blueSpriteNode runAction:repeatAction];
    }
    
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];;
        blueSpriteNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, (0.5-2*i)*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        
        SKAction *moveAction1 = [SKAction moveBy:CGVectorMake(-9*GAME_TILE_WIDTH,0) duration:1.5f];
        SKAction *moveAction2 = [moveAction1 reversedAction];
        SKAction *sequenceAction = [SKAction sequence:[NSArray arrayWithObjects:moveAction1,moveAction2, nil]];
        SKAction *repeatAction = [SKAction repeatActionForever:sequenceAction];
        [blueSpriteNode runAction:repeatAction];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint redBlockPosition = self.redBlockSprite.position;
    CGSize redBlockSize = self.redBlockSprite.size;
    if (redBlockPosition.x+redBlockSize.width/2 >= 6*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}







@end
