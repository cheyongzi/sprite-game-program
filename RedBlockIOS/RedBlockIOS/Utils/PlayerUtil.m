//
//  PlayerUtil.m
//  RedBlockIOS
//
//  Created by che on 15/7/2.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "PlayerUtil.h"

@implementation PlayerUtil

+ (instancetype)shareInstance {
    static PlayerUtil *playerUtil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        playerUtil = [[PlayerUtil alloc] init];
    });
    return playerUtil;
}


- (id)init {
    if (self = [super init]) {
        [self initPlayer];
    }
    return self;
}

- (void)initPlayer {
    NSError *error;
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"mp3"];
    NSURL *musicUrl = [NSURL URLWithString:musicFilePath];
    _musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:&error];
    _musicPlayer.numberOfLoops = -1;
    
    NSError *error1;
    NSString *soundPlayerPath1 = [[NSBundle mainBundle] pathForResource:@"bigBall" ofType:@"mp3"];
    NSURL   *soundUrl1 = [NSURL URLWithString:soundPlayerPath1];
    _soundPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl1 error:&error1];
    
    NSError *error2;
    NSString *soundPlayerPath2 = [[NSBundle mainBundle] pathForResource:@"smile" ofType:@"mp3"];
    NSURL   *soundUrl2 = [NSURL URLWithString:soundPlayerPath2];
    _soundPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:&error2];
    
    NSError *error3;
    NSString *soundPlayerPath3 = [[NSBundle mainBundle] pathForResource:@"crash" ofType:@"mp3"];
    NSURL   *soundUrl3 = [NSURL URLWithString:soundPlayerPath3];
    _soundPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl3 error:&error3];
}

- (void)playBackground {
    if ([_musicPlayer prepareToPlay]) {
        [_musicPlayer play];
    }
}

- (void)stopBackground {
    if (_musicPlayer) {
        [_musicPlayer stop];
    }
}

- (void)playStarSound {
    if ([_soundPlayer1 prepareToPlay]) {
        [_soundPlayer1 play];
    }
}

- (void)playSuccessSound {
    if ([_soundPlayer2 prepareToPlay]) {
        [_soundPlayer2 play];
    }
}

- (void)playCrashSound {
    if ([_soundPlayer3 prepareToPlay]) {
        [_soundPlayer3 play];
    }
}

@end
