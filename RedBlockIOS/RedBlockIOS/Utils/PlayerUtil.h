//
//  PlayerUtil.h
//  RedBlockIOS
//
//  Created by che on 15/7/2.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerUtil : NSObject

+ (instancetype)shareInstance;

@property (strong, nonatomic) AVAudioPlayer *musicPlayer;
@property (strong, nonatomic) AVAudioPlayer *soundPlayer1;
@property (strong, nonatomic) AVAudioPlayer *soundPlayer2;
@property (strong, nonatomic) AVAudioPlayer *soundPlayer3;

- (void)playBackground;
- (void)stopBackground;

- (void)playStarSound;
- (void)playSuccessSound;
- (void)playCrashSound;

@end
