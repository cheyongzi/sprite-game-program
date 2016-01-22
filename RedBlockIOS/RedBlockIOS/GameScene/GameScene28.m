//
//  GameScene28.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene28.h"
#import "StarSpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene28
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
    
    [self addDoorSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 8*GAME_TILE_WIDTH+2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -8*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<4; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-7.5*GAME_TILE_WIDTH+i*12*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH-i*10*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<4; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-7.5*GAME_TILE_WIDTH+i*12*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH+i*10*GAME_TILE_WIDTH-j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH-i*7*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH-j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<6; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    
    for (int i = 0; i<5; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-7.5*GAME_TILE_WIDTH, -6.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<5; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(7.5*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runActionWithSprite:spriteBlueNode withOrientation:-1];
    }
}

- (void)runActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*15*GAME_TILE_WIDTH, 0) duration:3.75f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(-1*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -6*GAME_TILE_WIDTH+j*12*GAME_TILE_WIDTH)];
            [self.mapNodeSprite addChild:starSprite];
        }
    }
}

- (void)addDoorSprite {
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(14*GAME_TILE_WIDTH, GAME_TILE_WIDTH)];
        [doorSprite initPhysicsBodyWithPosition:CGPointMake(0, -1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:doorSprite];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&
        position.x+GAME_TILE_WIDTH/2>-GAME_TILE_WIDTH&&
        position.x-GAME_TILE_WIDTH/2<GAME_TILE_WIDTH&&
        position.y-GAME_TILE_WIDTH/2<GAME_TILE_WIDTH&&
        position.y+GAME_TILE_WIDTH/2>-GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
