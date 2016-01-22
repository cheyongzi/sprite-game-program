//
//  GameScene13.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene13.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene13

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, 0);
    
    [self createBlueBall];
    
    [self addKeySprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    return pathRef;
    
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode1.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*6*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode1];
            [self runOneActionWithSprite:spriteBlueNode1 withOrientaion:-1];
        }
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runOneActionWithSprite:spriteBlueNode1 withOrientaion:1];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(4.5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runSecondActionWithSprite:spriteBlueNode1 withOrientation:-1];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(2.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runSecondActionWithSprite:spriteBlueNode1 withOrientation:1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientaion:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*2*GAME_TILE_WIDTH) duration:0.65];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*2*GAME_TILE_WIDTH, 0) duration:0.65];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addKeySprite {
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(-0.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:keySprite];
    
    DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
    [doorSprite initPhysicsBodyWithPosition:CGPointMake(-4*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:doorSprite];
}

- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (position.y+GAME_TILE_WIDTH/2>=3*GAME_TILE_WIDTH&&position.x-GAME_TILE_WIDTH/2<=-3*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end
