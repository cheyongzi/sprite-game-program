//
//  GameScene17.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene17.h"
#import "StarSpriteNode.h"

@implementation GameScene17
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -1*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -1*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 1*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 1*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 5*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -4*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, -GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -5*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 3.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
    }
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
    }
    
    for (int i = 1; i<=3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withActionWidth:(2*i+1)*GAME_TILE_WIDTH withOrientation:1];
    }
    
    for (int i = 1; i<=3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withActionWidth:(2*i+1)*GAME_TILE_WIDTH withOrientation:-1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withActionWidth:(int)actionWidth withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddLineToPoint(pathRef, NULL, orientation*actionWidth, 0);
    CGPathAddLineToPoint(pathRef, NULL, orientation*actionWidth, -orientation*actionWidth);
    CGPathAddLineToPoint(pathRef, NULL, 0, -orientation*actionWidth);
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *action = [SKAction followPath:pathRef duration:(actionWidth/GAME_TILE_WIDTH)*4*0.25];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH, 0)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    for (int i =0 ; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(0, -4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH)];
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
        position.x+GAME_TILE_WIDTH/2>-1*GAME_TILE_WIDTH&&
        position.x-GAME_TILE_WIDTH/2<1*GAME_TILE_WIDTH&&
        position.y+GAME_TILE_WIDTH/2>-1*GAME_TILE_WIDTH&&
        position.y-GAME_TILE_WIDTH/2<1*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
