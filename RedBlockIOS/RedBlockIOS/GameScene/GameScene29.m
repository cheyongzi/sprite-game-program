//
//  GameScene29.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene29.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene29
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(7*GAME_TILE_WIDTH, 5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addDoorSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<6; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*11*GAME_TILE_WIDTH, 0) duration:3.0f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*11*GAME_TILE_WIDTH) duration:2.75f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addDoorSprite {
    
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(-5*GAME_TILE_WIDTH, 0)];
    [self.mapNodeSprite addChild:keySprite];
    
    DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
    [doorSprite initPhysicsBodyWithPosition:CGPointMake(5.5*GAME_TILE_WIDTH, -5*GAME_TILE_WIDTH)];
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
    if (position.x+GAME_TILE_WIDTH/2>6*GAME_TILE_WIDTH&&
        position.y-GAME_TILE_WIDTH/2<-3*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
