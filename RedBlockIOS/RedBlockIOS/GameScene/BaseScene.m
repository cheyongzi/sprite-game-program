//
//  BaseScene.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "BaseScene.h"
#import "GameScene1.h"
#import "AppDelegate.h"
#import "CommonSceneUtils.h"
#import "StarSpriteNode.h"
#import "PlayerUtil.h"

@interface BaseScene ()
{
    SKSpriteNode *backgroundNode;
}
@end

@implementation BaseScene

+ (id)createScenWithLevelIndex:(NSInteger)levelIndex {
    return [[CommonSceneUtils shareInstance] createSceneWithLevel:levelIndex];
}

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    
    self.backgroundColor = [UIColor clearColor];
    
    backgroundNode = [SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
    backgroundNode.size = CGSizeMake(self.size.width, self.size.height);
    backgroundNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    backgroundNode.zPosition = -1;
    [self addChild:backgroundNode];
    
    [self createPhysicsScene];
}

#pragma mark 创建红块及地图场景
- (void)createPhysicsScene {
    self.mapNodeSprite = [[SKSpriteNode alloc] init];
    self.mapNodeSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    self.mapNodeSprite.physicsBody.restitution = 0.0f;
    self.mapNodeSprite.physicsBody.friction = 0.0f;
    [self addChild:self.mapNodeSprite];
    
    self.redBlockSprite = [SKSpriteNode spriteNodeWithImageNamed:@"redBlock.png"];
    self.redBlockSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(30, 30)];
    self.redBlockSprite.physicsBody.restitution = 0.0f;
    self.redBlockSprite.physicsBody.friction = 0.0f;
    self.redBlockSprite.physicsBody.allowsRotation = NO;
    self.redBlockSprite.physicsBody.usesPreciseCollisionDetection = YES;
    self.redBlockSprite.physicsBody.categoryBitMask = redBlockCategory;
    [self.mapNodeSprite addChild:self.redBlockSprite];
}

#pragma mark 蓝球的初始化
- (void)initBlueSpriteNode:(SKSpriteNode*)blueSpriteNode {
    blueSpriteNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
    blueSpriteNode.physicsBody.restitution = 0.0f;
    blueSpriteNode.physicsBody.friction = 0.0f;
    blueSpriteNode.physicsBody.allowsRotation = NO;
    blueSpriteNode.physicsBody.usesPreciseCollisionDetection = YES;
    blueSpriteNode.physicsBody.categoryBitMask = blueBallCategory;
    blueSpriteNode.physicsBody.collisionBitMask = redBlockCategory;
    blueSpriteNode.physicsBody.contactTestBitMask = redBlockCategory;
    [self.mapNodeSprite addChild:blueSpriteNode];
}

#pragma mark SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact {
    if (contact.bodyA.categoryBitMask&redBlockCategory || contact.bodyB.categoryBitMask&redBlockCategory)
    {
        //小红块与蓝色球的碰撞
        if (contact.bodyA.categoryBitMask&blueBallCategory || contact.bodyB.categoryBitMask&blueBallCategory)
        {
            if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
                [[PlayerUtil shareInstance] playCrashSound];
            }
            
            [self removeAllChildren];
            [self removeAllActions];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:Restart_Noti object:nil];
        }
        
        //小红块与星星的碰撞
        if (contact.bodyA.categoryBitMask&starCategory) {
            [contact.bodyA.node removeFromParent];
            if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
                [[PlayerUtil shareInstance] playStarSound];
            }
        }else if (contact.bodyB.categoryBitMask&starCategory){
            [contact.bodyB.node removeFromParent];
            if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
                [[PlayerUtil shareInstance] playStarSound];
            }
        }
        
        //小红块与钥匙的碰撞
        if (contact.bodyA.categoryBitMask&keyCategory){
            [contact.bodyA.node removeFromParent];
            [[self.mapNodeSprite childNodeWithName:@"Door"] removeFromParent];
        }else if(contact.bodyB.categoryBitMask&keyCategory) {
            [contact.bodyB.node removeFromParent];
            [[self.mapNodeSprite childNodeWithName:@"Door"] removeFromParent];
        }
    }
}

#pragma mark Update
- (void)update:(NSTimeInterval)currentTime {
    [self updateRedBlockSprite];
}

#pragma mark 更新小红块的位置
- (void)updateRedBlockSprite {
    float dx = 0;
    float dy = 0;
    if (_leftButtonPressDown) {
        if (_rightButtonPressDown) {
            dx = 0;
        }else {
            dx = -200;
        }
        
    } else {
        if (_rightButtonPressDown) {
            dx = 200;
        }else {
            dx = 0;
        }
    }
    
    if (_upButtonPressDown) {
        if (_downButtonPressDown) {
            dy = 0;
        }else {
            dy = 200;
        }
    }else {
        if (_downButtonPressDown) {
            dy = -200;
        }else {
            dy = 0;
        }
    }
    self.redBlockSprite.physicsBody.velocity = CGVectorMake(dx, dy);
}

#pragma mark Next Level
- (void)nextLevelGame {
//    [self removeAllActions];
//    [self removeAllChildren];
//    if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
//        [[PlayerUtil shareInstance] playSuccessSound];
//    }
    _isComletedLevel = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:Next_Noti object:nil];
}




@end
