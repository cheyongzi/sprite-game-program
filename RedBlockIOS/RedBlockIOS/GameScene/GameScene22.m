//
//  GameScene22.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene22.h"
#import "StarSpriteNode.h"

@implementation GameScene22
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-7*GAME_TILE_WIDTH, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 9*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -9*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*7*GAME_TILE_WIDTH) duration:1.75f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    StarSpriteNode *starSprite1 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite1 initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite1];
    
    StarSpriteNode *starSprite2 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite2 initPhysicsBodyWithPosition:CGPointMake(5.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite2];
    
    StarSpriteNode *starSprite3 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite3 initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite3];
    
    StarSpriteNode *starSprite4 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite4 initPhysicsBodyWithPosition:CGPointMake(5.5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite4];
}

- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (![self.mapNodeSprite childNodeWithName:@"star"]&&position.x+GAME_TILE_WIDTH/2>6*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
