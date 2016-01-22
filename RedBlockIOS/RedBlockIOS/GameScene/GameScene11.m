//
//  GameScene11.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene11.h"

@implementation GameScene11
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5*GAME_TILE_WIDTH, 5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode1.position = CGPointMake(-5.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode1];
    [self runOneActionWithSprite:spriteBlueNode1 withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(-4.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runOneActionWithSprite:spriteBlueNode2 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode3.position = CGPointMake(-5.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode3];
    [self runSecondActionWithSprite:spriteBlueNode3 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode4 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode4.position = CGPointMake(5.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode4];
    [self runSecondActionWithSprite:spriteBlueNode4 withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode5 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode5.position = CGPointMake(4.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode5];
    [self runOneActionWithSprite:spriteBlueNode5 withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode6 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode6.position = CGPointMake(5.5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode6];
    [self runOneActionWithSprite:spriteBlueNode6 withOrientation:1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveBy = [SKAction moveBy:CGVectorMake(0, orientation*4*GAME_TILE_WIDTH) duration:1.0f];
    SKAction *reverse = [moveBy reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveBy,reverse, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveBy = [SKAction moveBy:CGVectorMake(orientation*11*GAME_TILE_WIDTH, 0) duration:2.75f];
    SKAction *reverse = [moveBy reversedAction];
    SKAction *sequence = [SKAction sequence:[NSArray arrayWithObjects:moveBy,reverse, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:sequence];
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
    if (position.y-GAME_TILE_WIDTH/2<-4*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
