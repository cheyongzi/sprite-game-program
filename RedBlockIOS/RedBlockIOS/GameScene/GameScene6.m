//
//  GameScene6.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene6.h"
#import "StarSpriteNode.h"

@implementation GameScene6
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, -2*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-8.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runActionWithSprite:spriteBlueNode];
    }
}

- (void)runActionWithSprite:(SKSpriteNode*)sprite {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(17*GAME_TILE_WIDTH, 0) duration:4.25f];
    SKAction *reversedAction = [moveByAction reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reversedAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i =0 ; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(7.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH)];
            [self.mapNodeSprite addChild:starSprite];
        }
    }
    
    for (int i =0 ; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(-8.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH)];
            [self.mapNodeSprite addChild:starSprite];
        }
    }
}

- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.y-GAME_TILE_WIDTH/2<=-1.1*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
