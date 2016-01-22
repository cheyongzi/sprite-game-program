//
//  GameScene26.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/27.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene26.h"
#import "StarSpriteNode.h"

@implementation GameScene26
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-5*GAME_TILE_WIDTH, 3*GAME_TILE_WIDTH);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, -GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 4*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 6*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH-2);
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
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -6*GAME_TILE_WIDTH-2, 4*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-3.5*GAME_TILE_WIDTH+i*7*GAME_TILE_WIDTH, -3.5*GAME_TILE_WIDTH+j*7*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<2; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, -4.5*GAME_TILE_WIDTH+i*9*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
        }
    }
    
    SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
    spriteBlueNode.position = CGPointMake(0, 0);
    [self initBlueSpriteNode:spriteBlueNode];
    
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-3*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 0);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withStartAngle:M_PI withEndAngle:-M_PI withRadio:3*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH withOrientation:1];
    }
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 0);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runOneActionWithSprite:spriteBlueNode withStartAngle:0 withEndAngle:-2*M_PI withRadio:GAME_TILE_WIDTH+i*GAME_TILE_WIDTH withOrientation:-1];
    }
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(0, -3*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withStartAngle:3*M_PI/2 withEndAngle:-M_PI/2 withRadio:3*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH withOrientation:1];
    }
    for (int i = 0; i<3; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(0, GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runSecondActionWithSprite:spriteBlueNode withStartAngle:M_PI/2 withEndAngle:-3*M_PI/2 withRadio:GAME_TILE_WIDTH+i*GAME_TILE_WIDTH withOrientation:-1];
    }
}

- (void)runOneActionWithSprite:(SKSpriteNode*)sprite withStartAngle:(float)startAngle withEndAngle:(float)endAngle withRadio:(int)radio withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, orientation*radio, 0, radio, startAngle, endAngle, YES);
    SKAction *action = [SKAction followPath:pathRef duration:3.5f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runSecondActionWithSprite:(SKSpriteNode*)sprite withStartAngle:(float)startAngle withEndAngle:(float)endAngle withRadio:(int)radio withOrientation:(int)orientation {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    CGPathAddArc(pathRef, NULL, 0, orientation*radio, radio, startAngle, endAngle, YES);
    SKAction *action = [SKAction followPath:pathRef duration:3.5f];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    for (int i = 0; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-4*GAME_TILE_WIDTH+i*8*GAME_TILE_WIDTH, 0)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    for (int i = 0; i<2; i++) {
        StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
        [starSprite initPhysicsBodyWithPosition:CGPointMake(-3*GAME_TILE_WIDTH+i*6*GAME_TILE_WIDTH, -3*GAME_TILE_WIDTH)];
        [self.mapNodeSprite addChild:starSprite];
    }
    
    StarSpriteNode *starSprite1 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite1 initPhysicsBodyWithPosition:CGPointMake(0, 4*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite1];
    
    StarSpriteNode *starSprite2 = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite2 initPhysicsBodyWithPosition:CGPointMake(3*GAME_TILE_WIDTH, 3*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite2];
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
        position.x+GAME_TILE_WIDTH/2>4*GAME_TILE_WIDTH&&
        position.y+GAME_TILE_WIDTH/2>2*GAME_TILE_WIDTH)
    {
        [self nextLevelGame];
    }
}
@end
