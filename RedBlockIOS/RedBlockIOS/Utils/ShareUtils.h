//
//  ShareUtils.h
//  RedBlockIOS
//
//  Created by che on 15/6/30.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareUtils : UIView

+ (instancetype)shareInstance;

- (void)shareToFriendZone;

- (void)shareToWeChat;

- (void)shareToFaceBook;

- (void)shareToTweeter;

@end
