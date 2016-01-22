//
//  GameScene4.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene3.h"
#import "StarSpriteNode.h"

@implementation GameScene3

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-6.5*GAME_TILE_WIDTH, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self runActionWithSprite:blueSpriteNode];
        
        SKSpriteNode *blueSpriteNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode1.position = CGPointMake(1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode1];
        [self runActionWithSprite:blueSpriteNode1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        blueSpriteNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self runActionWithSprite:blueSpriteNode];
    }
}

- (void)runActionWithSprite:(SKSpriteNode*)spriteNode {
    CGPoint position = spriteNode.position;
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, -2*position.y) duration:1.25f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [spriteNode runAction:repeatAction];
}

- (void)addStarSprite {
    StarSpriteNode *starSprite1 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite1 initPhysicsBodyWithPosition:CGPointMake(2.0*GAME_TILE_WIDTH, -1.0*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite1];
    
    StarSpriteNode *starSprite2 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite2 initPhysicsBodyWithPosition:CGPointMake(-2.0*GAME_TILE_WIDTH, -1.0*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite2];
    
    StarSpriteNode *starSprite3 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite3 initPhysicsBodyWithPosition:CGPointMake(0, 1.0*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite3];
}

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    [self checkIsCompleteLevel];
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.x+GAME_TILE_WIDTH/2>=5.1*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end
