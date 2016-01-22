//
//  LevelClearView.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/6/28.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LevelClearDelegate <NSObject>

- (void)restartGame;

- (void)nextLevelGame;

- (void)menuAction;

@end

@interface LevelClearView : UIView

@property (nonatomic, weak) id<LevelClearDelegate> clearDelegate;

- (instancetype)initWithCurrentLevelIndex:(int)currentLevelIndex;

@end
