//
//  GameScene14.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene14.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"
#import "StarSpriteNode.h"

@implementation GameScene14
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-6*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addKeySprite];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    return pathRef;
    
}

- (void)createBlueBall {
    
    for (int i=0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode1.position = CGPointMake(-6.5*GAME_TILE_WIDTH+j*2*GAME_TILE_WIDTH, -GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode1];
            [self runOneActionWithSprite:spriteBlueNode1];
        }
    }
    
    for (int i=0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode1.position = CGPointMake(1.5*GAME_TILE_WIDTH+j*2*GAME_TILE_WIDTH, -GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode1];
            [self runOneActionWithSprite:spriteBlueNode1];
        }
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(-2.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runSecondActionWithSprite:spriteBlueNode1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0.5*GAME_TILE_WIDTH, 0, GAME_TILE_WIDTH/2, M_PI, -M_PI, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, -0.5*GAME_TILE_WIDTH, 0, GAME_TILE_WIDTH/2, 0, -2*M_PI, YES);
    SKAction *action = [SKAction followPath:pathRef duration:1.0f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addKeySprite {
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(6*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:keySprite];
    
    DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(GAME_TILE_WIDTH, GAME_TILE_WIDTH)];
    [doorSprite initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:doorSprite];
}

- (void)addStarSprite {
    for (int i=0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(-6.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH)];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.y-GAME_TILE_WIDTH/2<=-3*GAME_TILE_WIDTH&&position.x+GAME_TILE_WIDTH/2>=5*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
