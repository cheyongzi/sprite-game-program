//
//  GameScene27.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene27.h"

@implementation GameScene27
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-3*GAME_TILE_WIDTH, -5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<2; j++) {
            for (int z = 0; z<2; z++) {
                SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
                spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH+z*GAME_TILE_WIDTH);
                [self initBlueSpriteNode:spriteBlueNode];
            }
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            for (int z = 0; z<2; z++) {
                SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
                spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH+i*12*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+z*GAME_TILE_WIDTH);
                [self initBlueSpriteNode:spriteBlueNode];
            }
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            for (int z = 0; z<2; z++) {
                SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
                spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH+i*12*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+z*GAME_TILE_WIDTH);
                [self initBlueSpriteNode:spriteBlueNode];
            }
        }
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-7.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, 5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-7.5*GAME_TILE_WIDTH+j*12*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
            [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+j*12*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
            [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
        }
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH,0 );
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH, -orientation*3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, -orientation*3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *action = [SKAction followPath:pathRef duration:3];
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
    if (position.x-GAME_TILE_WIDTH/2<4*GAME_TILE_WIDTH&&position.y-GAME_TILE_WIDTH/2<-4*GAME_TILE_WIDTH&&position.x+GAME_TILE_WIDTH/2>2*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
