//
//  SettingsView.m
//  Demo
//
//  Created by che on 15/7/1.
//  Copyright (c) 2015年 che. All rights reserved.
//

#import "SettingsView.h"
#import "Utils.h"
#import "PlayerUtil.h"
#import "IAPUtil.h"

@interface SettingsView ()
{
    BOOL    isShowSettingMenu;
    
    UIView  *settingMenuView;
}

@end

@implementation SettingsView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initInterface];
    }
    return self;
}

- (void)initInterface {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 24;
    
    settingMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    settingMenuView.backgroundColor = [UIColor colorWithRed:116.f/255 green:183.f/255 blue:215.f/255 alpha:1.0f];
    settingMenuView.layer.cornerRadius = 24;
    settingMenuView.clipsToBounds = YES;
    [self addSubview:settingMenuView];
    
    UIButton    *settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-48, 48, 48)];
    [settingButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setImage:[UIImage imageNamed:@"settingBtn.png"] forState:UIControlStateNormal];
    [self addSubview:settingButton];
    
    UIButton *soundBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 15, 40, 40)];
    [soundBtn addTarget:self action:@selector(soundAction:) forControlEvents:UIControlEventTouchUpInside];
    if (![@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
        [soundBtn setImage:[UIImage imageNamed:@"noSound.png"] forState:UIControlStateNormal];
    }else{
        [soundBtn setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
    }
    [settingMenuView addSubview:soundBtn];
    
    UIButton    *musicBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 65, 40, 40)];
    [musicBtn addTarget:self action:@selector(musicAction:) forControlEvents:UIControlEventTouchUpInside];
    if (![@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_STATUS]]) {
        [musicBtn setImage:[UIImage imageNamed:@"noMusic.png"] forState:UIControlStateNormal];
    }else{
        [musicBtn setImage:[UIImage imageNamed:@"music.png"] forState:UIControlStateNormal];
    }
    [settingMenuView addSubview:musicBtn];
    
    UIButton    *infoBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 115, 40, 40)];
    [infoBtn addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [settingMenuView addSubview:infoBtn];
}

- (void)settingAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveLinear animations:^{
        settingMenuView.frame = isShowSettingMenu?CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height):self.bounds;
    } completion:^(BOOL finished) {
        isShowSettingMenu = !isShowSettingMenu;
        button.userInteractionEnabled = YES;
    }];
}

- (void)musicAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_STATUS]]) {
        [button setImage:[UIImage imageNamed:@"noMusic.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:MUSIC_STATUS];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[PlayerUtil shareInstance] stopBackground];
    }else{
        [button setImage:[UIImage imageNamed:@"music.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:MUSIC_STATUS];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[PlayerUtil shareInstance] playBackground];
    }
    button.userInteractionEnabled = YES;
}

- (void)soundAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]]) {
        [button setImage:[UIImage imageNamed:@"noSound.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:SOUND_STATUS];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [button setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:SOUND_STATUS];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    button.userInteractionEnabled = YES;
}

- (void)infoAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"title", nil) message:NSLocalizedString(@"info", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"confirmButton", nil) otherButtonTitles:nil, nil];
    [alertView show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
