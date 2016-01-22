//
//  Utils.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#ifndef RedBlockIOS_Utils_h
#define RedBlockIOS_Utils_h


#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define GAME_TILE_WIDTH 40

#define LEFT_MOVE_TAG   100
#define RIGHT_MOVE_TAG  101
#define UP_MOVE_TAG     102
#define DOWN_MOVE_TAG   103

static const uint32_t redBlockCategory = 0x1<<0;
static const uint32_t blueBallCategory = 0x1<<1;
static const uint32_t mapCategory = 0x1<<2;
static const uint32_t starCategory = 0x1<<3;
static const uint32_t keyCategory = 0x1<<4;

//游戏中本地数据的存储
#define COMPLETE_LEVEL      @"completeLevel"
#define MAX_ONCE_LEVEL      @"maxOnceLevel"
#define DEATH_COUNT         @"deathCount"
#define LEVEL_STAR          @"levelStar"
#define LEVEL_DEATH         @"levelDeathCount"
#define MUSIC_STATUS        @"musicStatus"
#define SOUND_STATUS        @"soundStatus"
#define CLEAR_PROS          @"clearPros"

//游戏中通知类型
#define Restart_Noti        @"restartGameNotification"
#define Next_Noti           @"nextLevelGameNotification"

#endif
