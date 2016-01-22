//
//  PauseView.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/9.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PauseViewDelegate <NSObject>

 @optional

//继续游戏
- (void)resumeGame;
//回到菜单页
- (void)backToMenu;
//SettingAction
- (void)settingAction;

@end

@interface PauseView : UIView

+(instancetype)initWithLevelIndex:(NSInteger)levelIndex;

@property (weak, nonatomic) id<PauseViewDelegate>   pauseDelegate;

@end
