//
//  GameScene7.m
//  RedBlockIOS
//
//  Created by che on 15/5/8.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameScene7.h"

@implementation GameScene7
- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    CGMutablePathRef pathRef = [self createMapPath];
    self.mapNodeSprite.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:pathRef];
    
    self.redBlockSprite.position = CGPointMake(-3*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH);
    
    [self createBlueBall];
}

- (CGMutablePathRef)createMapPath {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 7*GAME_TILE_WIDTH+2);
    CGPathAddLineToPoint(pathRef, NULL, 4*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, 2*GAME_TILE_WIDTH+2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, -7*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -2*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 5*GAME_TILE_WIDTH-2);
    CGPathAddLineToPoint(pathRef, NULL, -4*GAME_TILE_WIDTH-2, 7*GAME_TILE_WIDTH+2);
    return pathRef;
}

- (void)createBlueBall {
    for (int i = 0; i<6; i++) {
        for (int j = 0; j< 3; j++) {
            SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
            spriteBlueNode.position = CGPointMake(-GAME_TILE_WIDTH+j*GAME_TILE_WIDTH, 6*GAME_TILE_WIDTH-i*2*GAME_TILE_WIDTH);
            [self initBlueSpriteNode:spriteBlueNode];
            if (i%2 == 0) {
                [self runReverseActionWithSprite:spriteBlueNode];
            }else{
                [self runActionWithSprite:spriteBlueNode];
            }
            
        }
    }
    
    for (int i = 0; i<2; i++) {
        SKSpriteNode *spriteBlueNode = [SKSpriteNode spriteNodeWithImageNamed:@"blueBall.png"];
        spriteBlueNode.position = CGPointMake(-GAME_TILE_WIDTH+i*2*GAME_TILE_WIDTH, -6*GAME_TILE_WIDTH);
        [self initBlueSpriteNode:spriteBlueNode];
        [self runReverseActionWithSprite:spriteBlueNode];
    }
}

- (void)runActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef actionPath = CGPathCreateMutable();
    CGPathMoveToPoint(actionPath, NULL, 0, 0);
    CGPathAddLineToPoint(actionPath, NULL, -0.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(actionPath, NULL, 0, 0);
    CGPathAddLineToPoint(actionPath, NULL, 0.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(actionPath, NULL, 0, 0);
    SKAction *action = [SKAction followPath:actionPath duration:0.75];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
    [sprite runAction:repeatAction];
}

- (void)runReverseActionWithSprite:(SKSpriteNode*)sprite {
    CGMutablePathRef actionPath = CGPathCreateMutable();
    CGPathMoveToPoint(actionPath, NULL, 0, 0);
    CGPathAddLineToPoint(actionPath, NULL, 0.5*GAME_TILE_WIDTH, -0.5*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(actionPath, NULL, 0, 0);
    CGPathAddLineToPoint(actionPath, NULL, -0.5*GAME_TILE_WIDTH, 0.5*GAME_TILE_WIDTH);
    CGPathAddLineToPoint(actionPath, NULL, 0, 0);
    SKAction *action = [SKAction followPath:actionPath duration:0.75];
    SKAction *repeatAction = [SKAction repeatActionForever:action];
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
    if (position.x+GAME_TILE_WIDTH/2 >= 2.1*GAME_TILE_WIDTH) {
        [self nextLevelGame];
    }
}
@end
