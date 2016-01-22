//
//  GameScene25.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene25.h"
#import "StarSpriteNode.h"
#import "DoorSpriteNode.h"

@implementation GameScene25
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
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+i*13*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1 withActionWidth:7*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*11*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1 withActionWidth:7*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH+i*5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1 withActionWidth:4*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-2.5*GAME_TILE_WIDTH+i*5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1 withActionWidth:4*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH, 5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1 withActionWidth:4*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH+i*3*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1 withActionWidth:4*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH+i*11*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:1 withActionWidth:9*GAME_TILE_WIDTH];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(4.5*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withOrientation:-1 withActionWidth:9*GAME_TILE_WIDTH];
    }
    
    SKSpriteNode *spriteBlueNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode1.position = CGPointMake(-2.5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode1];
    [self runSecondActionWithSprite:spriteBlueNode1 withOrientation:1 withActionWidth:5*GAME_TILE_WIDTH];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(2.5*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runSecondActionWithSprite:spriteBlueNode2 withOrientation:-1 withActionWidth:5*GAME_TILE_WIDTH];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation withActionWidth:(int)actionWidth {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(0, orientation*actionWidth) duration:(actionWidth/GAME_TILE_WIDTH)*0.25];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation withActionWidth:(int)actionWidth {
    SKAction *moveByAction = [SKAction moveBy:CGVectorMake(orientation*actionWidth, 0) duration:(actionWidth/GAME_TILE_WIDTH)*0.25];
    SKAction *reverseAction = [moveByAction reversedAction];
    SKAction *action = [SKAction sequence:[NSArray arrayWithObjects:moveByAction,reverseAction, nil]];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
            [starSprite initPhysicsBodyWithPosition:CGPointMake(-5.5*GAME_TILE_WIDTH+i*10*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+j*9*GAME_TILE_WIDTH)];
            [self.mapNodeSprite addChild:starSprite];
        }
    }
}

- (void)addDoorSprite {
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
        [doorSprite initPhysicsBodyWithPosition:CGPointMake(0, -3*GAME_TILE_WIDTH+i*6*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:doorSprite];
    }
    
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 8*GAME_TILE_WIDTH)];
        [doorSprite initPhysicsBodyWithPosition:CGPointMake(-4*GAME_TILE_WIDTH+i*8*GAME_TILE_WIDTH, 0)];
        [self.mapNodeSprite addChild:doorSprite];
    }
    
    for (int i = 0; i<2; i++) {
        DoorSpriteNode *doorSprite = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(GAME_TILE_WIDTH, 2*GAME_TILE_WIDTH)];
        [doorSprite initPhysicsBodyWithPosition:CGPointMake(-2.5*GAME_TILE_WIDTH+i*5*GAME_TILE_WIDTH, 0)];
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
        position.x+GAME_TILE_WIDTH/2>-2*GAME_TILE_WIDTH&&
        position.x-GAME_TILE_WIDTH/2<2*GAME_TILE_WIDTH&&
        position.y-GAME_TILE_WIDTH/2<GAME_TILE_WIDTH&&
        position.y+GAME_TILE_WIDTH/2>-GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
