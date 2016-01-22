//
//  UserDataUtil.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/9.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "UserDataUtil.h"
#import "Utils.h"

@implementation UserDataUtil

+ (void)setCompleteLevelDataWithLevelIndex:(NSInteger)levelIndex {
    int completeLeveIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:COMPLETE_LEVEL] intValue];
    if (levelIndex+1 == completeLeveIndex) {
        completeLeveIndex+=1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",completeLeveIndex] forKey:COMPLETE_LEVEL];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)setDeathCountDataWithLevelIndex:(NSInteger)levelIndex {
    int completeLeveIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:COMPLETE_LEVEL] intValue];
    if (levelIndex+1 == completeLeveIndex) {
        int deathCount = [[[NSUserDefaults standardUserDefaults] objectForKey:DEATH_COUNT] intValue];
        deathCount+=1;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",deathCount] forKey:DEATH_COUNT];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)setLevelDeathCountDataWithLevelIndex:(NSInteger)levelIndex {
    NSMutableArray *mulArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_DEATH] mutableCopy];
    int deathCount = [[mulArray objectAtIndex:levelIndex] intValue]+1;
    [mulArray replaceObjectAtIndex:levelIndex withObject:[NSString stringWithFormat:@"%d",deathCount]];
    [[NSUserDefaults standardUserDefaults] setObject:mulArray forKey:LEVEL_DEATH];
}

@end
