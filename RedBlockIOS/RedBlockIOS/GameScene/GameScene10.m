//
//  GameScene10.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene10.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene10

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5*GAME_TILE_WIDTH, 5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addKeySprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
            [self runSecondActionWithSprite:spriteBlueNode withOrientation:1];
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
            [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1];
        }
    }
    
    SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode];
    [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(-6.5*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runOneActionWithSprite:spriteBlueNode2 withOrientation:1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveBy = [SKAction moveBy:CGVectorMake(orientation*11*GAME_TILE_WIDTH, 0) duration:2.75f];
    SKAction *reverse = [moveBy reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveBy,reverse, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveBy = [SKAction moveBy:CGVectorMake(0, -orientation*2*GAME_TILE_WIDTH) duration:0.5f];
    SKAction *reverse = [moveBy reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveBy,reverse, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)addKeySprite {
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(6*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:keySprite];
    
    DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(3*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
    [doorSprite initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH, 0)];
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
    if (position.y-GAME_TILE_WIDTH/2<-4*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end
