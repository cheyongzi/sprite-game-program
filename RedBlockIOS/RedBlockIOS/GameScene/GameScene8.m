//
//  GameScene8.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene8.h"
#import "StarSpriteNode.h"

@implementation GameScene8
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(2.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(5.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runHActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for ( int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runVActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for ( int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runVActionWithSprite:spriteBlueNode withOrientation:1];
    }
}

- (void)runHActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*3*GAME_TILE_WIDTH, 0) duration:1.0f];
    SKAction *reversedAction = [moveByAction reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reversedAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)runVActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation{
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*3*GAME_TILE_WIDTH) duration:1.0f];
    SKAction *reversedAction = [moveByAction reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reversedAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i =0 ; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(-0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH)];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.y+GAME_TILE_WIDTH/2>2*GAME_TILE_WIDTH&&position.y+GAME_TILE_WIDTH/2>4*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
