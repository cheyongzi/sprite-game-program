//
//  GameScene23.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene23.h"
#import "StarSpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene23
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-4.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addDoorSprite];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(3.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(-2.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runSecondActionWithSprite:spriteBlueNode2];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH, 0);
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, -3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *action = [SKAction followPath:pathRef duration:3];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH, 0);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH, -7*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, -7*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *action = [SKAction followPath:pathRef duration:5];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addDoorSprite {
    for (int i = 0; i<3; i++) {
        DoorSpriteNode *door = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
        [door initPhysicsBodyWithPosition:CGPointMake(2*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:door];
    }
    
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *door = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
        [door initPhysicsBodyWithPosition:CGPointMake(-4*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:door];
    }
    
    DoorSpriteNode *door1 = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, GAME_TILE_WIDTH)];
    [door1 initPhysicsBodyWithPosition:CGPointMake(-4*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:door1];
    
    DoorSpriteNode *door2 = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(GAME_TILE_WIDTH, GAME_TILE_WIDTH)];
    [door2 initPhysicsBodyWithPosition:CGPointMake(-3.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:door2];
    
    DoorSpriteNode *door3 = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH)];
    [door3 initPhysicsBodyWithPosition:CGPointMake(-GAME_TILE_WIDTH, 0)];
    [self.mapNodeSprite addChild:door3];
}

- (void)addStarSprite {
    for (int i = 0; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite initPhysicsBodyWithPosition:CGPointMake(3.5*GAME_TILE_WIDTH, 4.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite];
}

- (void)update:(NSTimeInterval)currentTime{
    [super update:currentTime];
    
    if (!self.isComletedLevel) {
        [self checkIsCompleteLevel];
    }
}

- (void)checkIsCompleteLevel {
    CGPoint position = self.redBlockSprite.position;
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.x+GAME_TILE_WIDTH/2>4*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
