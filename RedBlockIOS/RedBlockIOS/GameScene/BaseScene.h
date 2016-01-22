//
//  BaseScene.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKScene+Unarchive.h"
#import "Utils.h"

@interface BaseScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode  *redBlockSprite;
@property (nonatomic, strong) SKSpriteNode  *mapNodeSprite;

@property (nonatomic, assign) BOOL    leftButtonPressDown;
@property (nonatomic, assign) BOOL    rightButtonPressDown;
@property (nonatomic, assign) BOOL    upButtonPressDown;
@property (nonatomic, assign) BOOL    downButtonPressDown;

@property (nonatomic, assign) BOOL    isComletedLevel;

+ (id)createScenWithLevelIndex:(NSInteger)levelIndex;

- (void)nextLevelGame;

- (void)initBlueSpriteNode:(SKSpriteNode*)blueSpriteNode;

@end
