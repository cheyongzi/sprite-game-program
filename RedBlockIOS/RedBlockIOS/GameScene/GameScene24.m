//
//  GameScene24.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene24.h"

@implementation GameScene24
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, -4*GAME_TILE_WIDTH);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<5; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<5; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode1.position = CGPointMake(-4.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode1];
    [self runSecondActionWithSprite:spriteBlueNode1 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(4.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runSecondActionWithSprite:spriteBlueNode2 withOrientation:-1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*5*GAME_TILE_WIDTH) duration:1.25f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*9*GAME_TILE_WIDTH, 0) duration:2.25f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
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
    if (position.y+GAME_TILE_WIDTH/2>3*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
