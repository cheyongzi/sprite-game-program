//
//  GameScene2.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene2.h"
#import "StarSpriteNode.h"

@implementation GameScene2

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-8*GAME_TILE_WIDTH, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i < 6; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        
        SKAction *moveAction1 = [SKAction moveBy:CGVectorMake(0,-5*GAME_TILE_WIDTH) duration:1.25f];
        SKAction *moveAction2 = [moveAction1 reversedAction];
        SKAction *sequenceAction = [SKAction sequence:[NSArray arrayWithObjects:moveAction1,moveAction2, nil]];
        SKAction *repeatAction = [SKAction repeatActionForever:sequenceAction];
        [blueSpriteNode runAction:repeatAction];
    }
    
    for (int i = 0; i < 6; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        
        SKAction *moveAction1 = [SKAction moveBy:CGVectorMake(0,5*GAME_TILE_WIDTH) duration:1.25f];
        SKAction *moveAction2 = [moveAction1 reversedAction];
        SKAction *sequenceAction = [SKAction sequence:[NSArray arrayWithObjects:moveAction1,moveAction2, nil]];
        SKAction *repeatAction = [SKAction repeatActionForever:sequenceAction];
        [blueSpriteNode runAction:repeatAction];
    }
}

- (void)addStarSprite {
    StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite initPhysicsBodyWithPosition:CGPointMake(0, 0)];
    [self.mapNodeSprite addChild:starSprite];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&redBlockPosition.x+redBlockSize.width/2 >= 6.1*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end
