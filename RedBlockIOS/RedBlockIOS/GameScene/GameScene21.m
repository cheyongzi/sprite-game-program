//
//  GameScene21.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene21.h"
#import "KeySpriteNode.h"
#import "DoorSpriteNode.h"
#import "StarSpriteNode.h"

@implementation GameScene21
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, -GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addKeySprite];
    
    [self addDoorSprite];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -3*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 3*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 6*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 7*GAME_TILE_WIDTH+2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, -3*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, -6*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -7*GAME_TILE_WIDTH-2, 6*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<3; i++) {
        for (int j = 0; j<2; j++) {
            for (int z = 0; z<2; z++) {
                SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
                spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+z*GAME_TILE_WIDTH);
                [self initBlueSpriteNode:spriteBlueNode];
            }
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            for (int z = 0; z<2; z++) {
                SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
                spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH+i*10*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+z*GAME_TILE_WIDTH);
                [self initBlueSpriteNode:spriteBlueNode];
            }
        }
    }
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-5.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, -5.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*4*GAME_TILE_WIDTH, -2.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH+i*10*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*10*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withOrientation:-1];
    }
    
    SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode.position = CGPointMake(-6.5*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode];
    [self runOneActionWithSprite:spriteBlueNode withOrientation:1];
    
    SKSpriteNode *spriteBlueNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode2.position = CGPointMake(-3.5*GAME_TILE_WIDTH, 5.5*GAME_TILE_WIDTH);
    [self initBlueSpriteNode:spriteBlueNode2];
    [self runOneActionWithSprite:spriteBlueNode2 withOrientation:-1];
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, 0, orientation*3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH, orientation*3*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(pathRef, NULL, orientation*3*GAME_TILE_WIDTH, 0);
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *action = [SKAction followPath:pathRef duration:3];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addKeySprite {
    KeySpriteNode *keySprite = [KeySpriteNode spriteNodeWithImageNamed:@"key.png"];
    [keySprite initPhysicsBodyWithPosition:CGPointMake(5*GAME_TILE_WIDTH, 4.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:keySprite];
}

- (void)addDoorSprite {
    DoorSpriteNode *door = [DoorSpriteNode spriteNodeWithColor:[UIColor lightGrayColor] size:CGSizeMake(2*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH)];
    [door initPhysicsBodyWithPosition:CGPointMake(-2*GAME_TILE_WIDTH, 4*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:door];
}

- (void)addStarSprite {
    for (int i = 0; i<3; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(0, 3*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH)];
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
    if (![self.mapNodeSprite childNodeWithName:@"Star"]&&
        position.y-GAME_TILE_WIDTH/2<0&&
        position.y+GAME_TILE_WIDTH/2>-2*GAME_TILE_WIDTH&&
        position.x-GAME_TILE_WIDTH/2<GAME_TILE_WIDTH&&
        position.x+GAME_TILE_WIDTH/2>GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
