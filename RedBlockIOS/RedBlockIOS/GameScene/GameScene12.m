//
//  GameScene12.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene12.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene12

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-4*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addKeySprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, 2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH-2, 2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    return pathRef;

}

- (void)createBlueBall {
    for (int i = 0; i<4; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(-0.5*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runOneActionWithSprite:spriteBlueNode1];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode1.position = CGPointMake(0.5*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode1];
        [self runSecondActionWithSprite:spriteBlueNode1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 2*GAME_TILE_WIDTH, 0, 2*GAME_TILE_WIDTH, M_PI, -M_PI_2, NO);
    SKAction *pathAction = [SKAction followPath:pathRef duration:0.6f];
    SKAction *reverseAction = [pathAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:pathAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0, 2*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH, -M_PI_2, M_PI, YES);
    SKAction *pathAction = [SKAction followPath:pathRef duration:0.6f];
    SKAction *reverseAction = [pathAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:pathAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addKeySprite {
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(3.5*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:keySprite];
    
    DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
    [doorSprite initPhysicsBodyWithPosition:CGPointMake(2.5*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH)];
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
    if (position.y+GAME_TILE_WIDTH/2>=5*GAME_TILE_WIDTH&&position.x+GAME_TILE_WIDTH/2>=5*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}

@end