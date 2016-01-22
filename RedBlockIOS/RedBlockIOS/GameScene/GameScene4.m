//
//  GameScene4.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene4.h"
#import "StarSpriteNode.h"

@implementation GameScene4

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5.5*GAME_TILE_WIDTH, 3*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self runActionWithSprite:blueSpriteNode];
    }
    for (int i = 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(6.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self runActionWithSprite:blueSpriteNode];
    }
}

- (void)runActionWithSprite:(SKSpriteNode*)blueSpriteNode {
    CGPoint position = blueSpriteNode.position;
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(-2*position.x, 0) duration:2.5];
    SKAction *reversedAction = [moveByAction reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reversedAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [blueSpriteNode runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i = 0; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(0, -1.0*GAME_TILE_WIDTH+2*i*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.y-GAME_TILE_WIDTH/2<=2.1*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end
