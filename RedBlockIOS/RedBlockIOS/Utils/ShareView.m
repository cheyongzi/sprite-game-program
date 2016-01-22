//
//  ShareView.m
//  RedBlockIOS
//
//  Created by che on 15/6/30.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "ShareView.h"
#import "Utils.h"
#import "ShareUtils.h"

@interface ShareView ()
{
    BOOL    isShowSettingMenu;
    
    UIView  *shareMenuView;
}
@end

@implementation ShareView

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
    
    shareMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    shareMenuView.backgroundColor = [UIColor colorWithRed:116.f/255 green:183.f/255 blue:215.f/255 alpha:1.0f];
    shareMenuView.layer.cornerRadius = 24;
    shareMenuView.clipsToBounds = YES;
    [self addSubview:shareMenuView];
    
    UIButton    *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-48, 48, 48)];
    [shareButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"settingBtn.png"] forState:UIControlStateNormal];
    [self addSubview:shareButton];
    
//    UIButton *faceBookBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 15, 40, 40)];
//    [faceBookBtn addTarget:self action:@selector(fbAction:) forControlEvents:UIControlEventTouchUpInside];
//    [faceBookBtn setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
//    [shareMenuView addSubview:faceBookBtn];
//    
//    UIButton    *tweentBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 65, 40, 40)];
//    [tweentBtn addTarget:self action:@selector(tweetAction:) forControlEvents:UIControlEventTouchUpInside];
//    [tweentBtn setImage:[UIImage imageNamed:@"tw.png"] forState:UIControlStateNormal];
//    [shareMenuView addSubview:tweentBtn];
    
    UIButton    *chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 15, 40, 40)];
    [chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [chatBtn setImage:[UIImage imageNamed:@"wechat-icon.png"] forState:UIControlStateNormal];
    [shareMenuView addSubview:chatBtn];
    
    UIButton    *friendBtn = [[UIButton alloc] initWithFrame:CGRectMake(4, 65, 40, 40)];
    [friendBtn addTarget:self action:@selector(friendAction:) forControlEvents:UIControlEventTouchUpInside];
    [friendBtn setImage:[UIImage imageNamed:@"friends-icon.png"] forState:UIControlStateNormal];
    [shareMenuView addSubview:friendBtn];
}

- (void)settingAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0f options:UIViewAnimationOptionCurveLinear animations:^{
        shareMenuView.frame = isShowSettingMenu?CGRectMake(0, self.bounds.size.height, self.bounds.size.width, self.bounds.size.height):self.bounds;
    } completion:^(BOOL finished) {
        isShowSettingMenu = !isShowSettingMenu;
        button.userInteractionEnabled = YES;
    }];
}

- (void)fbAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    
    button.userInteractionEnabled = YES;
}

- (void)tweetAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    
    button.userInteractionEnabled = YES;
}

- (void)chatAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    [[ShareUtils shareInstance] shareToWeChat];
    button.userInteractionEnabled = YES;
}

- (void)friendAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.userInteractionEnabled = NO;
    [[ShareUtils shareInstance] shareToFriendZone];
    button.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
