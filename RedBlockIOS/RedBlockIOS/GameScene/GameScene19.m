//
//  GameScene19.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene19.h"
#import "StarSpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene19
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, -5*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
    
    [self addDoorSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH, 5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode1.position = CGPointMake(-3.5*GAME_TILE_WIDTH, GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode1];
    [self runThirdActionWithSprite:spriteBlueNode1 withOrientation:-1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(3.5*GAME_TILE_WIDTH, GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runThirdActionWithSprite:spriteBlueNode2 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode3.position = CGPointMake(0, 4.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode3];
    [self runFourthActionWithSprite:spriteBlueNode3 withOrientation:1];
    
    SKSpriteNode *spriteBlueNode4 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode4.position = CGPointMake(0, -2.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode4];
    [self runFourthActionWithSprite:spriteBlueNode4 withOrientation:-1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*9*GAME_TILE_WIDTH) duration:2.25f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*9*GAME_TILE_WIDTH, 0) duration:2.25f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runThirdActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*GAME_TILE_WIDTH, 0) duration:0.35f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runFourthActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*GAME_TILE_WIDTH) duration:0.35f];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i =0 ; i<4; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-3*GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, 5*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
    }
}

- (void)addDoorSprite {
    DoorSpriteNode *door = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(6*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH)];
    [door initPhysicsBodyWithPosition:CGPointMake(0, 1*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:door];
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
