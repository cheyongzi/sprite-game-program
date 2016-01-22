//
//  GameScene16.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene16.h"
#import "DoorSpriteNode.h"
#import "StarSpriteNode.h"

@implementation GameScene16
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-6*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addDoorSprite];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 4.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode1.position = CGPointMake(-3.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode1];
    [self runOneActionWithSprite:spriteBlueNode1 withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(-3.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runOneActionWithSprite:spriteBlueNode2 withOrientation:1];
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(1.5*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    SKSpriteNode *spriteBlueNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode3.position = CGPointMake(-1.5*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode3];
    [self runSecondActionWithSprite:spriteBlueNode3 withOrientation:1];
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    SKSpriteNode *spriteBlueNode4 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode4.position = CGPointMake(1.5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode4];
    [self runSecondActionWithSprite:spriteBlueNode4 withOrientation:-1];
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(2.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(2.5*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    SKSpriteNode *spriteBlueNode5 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode5.position = CGPointMake(3.5*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode5];
    [self runOneActionWithSprite:spriteBlueNode5 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode6 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode6.position = CGPointMake(3.5*GAME_TILE_WIDTH, 4.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode6];
    [self runOneActionWithSprite:spriteBlueNode6 withOrientation:-1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*4*GAME_TILE_WIDTH) duration:1.0f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*3*GAME_TILE_WIDTH, 0) duration:0.75];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addDoorSprite {
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(1*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH)];
        [doorSprite initPhysicsBodyWithPosition:CGPointMake(-1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH, 0)];
        [self.mapNodeSprite addChild:doorSprite];
    }
    
    DoorSpriteNode *doorSprite1 = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(1*GAME_TILE_WIDTH, 1*GAME_TILE_WIDTH)];
    [doorSprite1 initPhysicsBodyWithPosition:CGPointMake(-0.5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:doorSprite1];
    
    DoorSpriteNode *doorSprite2 = [DoorSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(1*GAME_TILE_WIDTH, 1*GAME_TILE_WIDTH)];
    [doorSprite2 initPhysicsBodyWithPosition:CGPointMake(0.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:doorSprite2];
}

- (void)addStarSprite {
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH, 0)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(0, -3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH)];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&position.x+GAME_TILE_WIDTH/2>5*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
