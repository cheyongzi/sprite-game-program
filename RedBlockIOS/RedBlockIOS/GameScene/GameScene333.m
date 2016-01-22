//
//  GameScene33.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene333.h"

@implementation GameScene333

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(0, 0);
    
    [self createBlueBall];
    
    [self addStarSprite];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef mulPathRef = CGPathCreateMutable();
    CGPathMoveToPoint(mulPathRef, NULL, -2*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(mulPathRef, NULL, -GAME_TILE_WIDTH+2, 3*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(mulPathRef, NULL, -GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(mulPathRef, NULL, 2*GAME_TILE_WIDTH+2, 2*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(mulPathRef, NULL, 2*GAME_TILE_WIDTH+2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(mulPathRef, NULL, -2*GAME_TILE_WIDTH-2, -2*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(mulPathRef, NULL, -2*GAME_TILE_WIDTH-2, 3*GAME_TILE_WIDTH+2);
    return mulPathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<3; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];;
        blueSpriteNode.position = CGPointMake(-1.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self createActionPath:blueSpriteNode];
    }
    
    for (int i= 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];;
        blueSpriteNode.position = CGPointMake(-0.5*GAME_TILE_WIDTH+i*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self createActionPath:blueSpriteNode];
    }
    
    for (int i = 0; i<4; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];;
        blueSpriteNode.position = CGPointMake(1.5*GAME_TILE_WIDTH, 1.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self createActionPath:blueSpriteNode];
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *blueSpriteNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];;
        blueSpriteNode.position = CGPointMake(0.5*GAME_TILE_WIDTH-i*GAME_TILE_WIDTH, -1.5*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:blueSpriteNode];
        [self createActionPath:blueSpriteNode];
    }
}

- (void)createActionPath:(SKSpriteNode*)sprite {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPoint position = sprite.position;
    CGPathMoveToPoint(pathRef, NULL, 0, 0);
    if (position.x == -1.5*GAME_TILE_WIDTH || position.x == 1.5*GAME_TILE_WIDTH) {
        CGPathAddLineToPoint(pathRef, NULL, 0, -position.x-(position.y));
        CGPathAddLineToPoint(pathRef, NULL, -position.x*2, -position.x-(position.y));
        CGPathAddLineToPoint(pathRef, NULL, -position.x*2, position.x-(position.y));
        CGPathAddLineToPoint(pathRef, NULL, 0, position.x-(position.y));
    }else{
        CGPathAddLineToPoint(pathRef, NULL, (position.y)-position.x, 0);
        CGPathAddLineToPoint(pathRef, NULL, (position.y)-position.x, -(position.y)*2);
        CGPathAddLineToPoint(pathRef, NULL, -(position.y)-position.x, -(position.y)*2);
        CGPathAddLineToPoint(pathRef, NULL, -(position.y)-position.x, 0);
    }
    CGPathAddLineToPoint(pathRef, NULL, 0, 0);
    SKAction *pathAction = [SKAction followPath:pathRef duration:4.0];
    SKAction *repeatAction = [SKAction repeatActionForever:pathAction];
    [sprite runAction:repeatAction];
}

- (void)addStarSprite {
    StarSpriteNode *starSprite = [StarSpriteNode spriteNodeWithImageNamed:@"star.png"];
    [starSprite initPhysicsBodyWithPosition:CGPointMake(-1.5*GAME_TILE_WIDTH, 2.5*GAME_TILE_WIDTH)];
    [self.mapNodeSprite addChild:starSprite];
}

- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    [self checkIsCompleteLevel];
}

- (void)checkIsCompleteLevel {
    CGPoint redBlockPosition = self.redBlockSprite.position;
    CGSize redBlockSize = self.redBlockSprite.size;
    if (![self.mapNodeSprite childNodeWithName:@"Star"] && redBlockPosition.y+redBlockSize.height/2 <= 0.5*GAME_TILE_WIDTH ) {
        [self nextLevelGame];
    }
}

@end
