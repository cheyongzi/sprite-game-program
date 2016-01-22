//
//  GameScene18.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene18.h"
#import "StarSpriteNode.h"

@implementation GameScene18
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, 5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(3.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*7*GAME_TILE_WIDTH) duration:1.75f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*7*GAME_TILE_WIDTH, 0) duration:1.75f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-3*GAME_TILE_WIDTH, -1*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(3*GAME_TILE_WIDTH, -1*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.y-GAME_TILE_WIDTH/2<-4*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
