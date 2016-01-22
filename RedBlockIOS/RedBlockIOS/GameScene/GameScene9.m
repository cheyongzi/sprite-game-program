//
//  GameScene9.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene9.h"
#import "StarSpriteNode.h"

@implementation GameScene9
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5*GAME_TILE_WIDTH, 5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runVActionWithSprite:spriteBlueNode];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runVReverseActionWithSprite:spriteBlueNode];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHActionWIthSprite:spriteBlueNode];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHReverserActionWithSprite:spriteBlueNode];
    }
}

- (void)runVActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0, -0.5*GAME_TILE_WIDTH, GAME_TILE_WIDTH/2, M_PI/2, -3*M_PI_2, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runVReverseActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0, 0.5*GAME_TILE_WIDTH, GAME_TILE_WIDTH/2, 3*M_PI/2, -M_PI_2, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runHActionWIthSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0.5*GAME_TILE_WIDTH, 0, GAME_TILE_WIDTH/2, M_PI, -M_PI, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runHReverserActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, -0.5*GAME_TILE_WIDTH, 0, GAME_TILE_WIDTH/2, 0, -2*M_PI, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (position.x+GAME_TILE_WIDTH/2>4*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
