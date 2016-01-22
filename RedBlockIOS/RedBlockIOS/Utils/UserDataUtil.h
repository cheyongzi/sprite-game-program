//
//  UserDataUtil.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/9.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataUtil : NSObject

+ (void)setCompleteLevelDataWithLevelIndex:(NSInteger)levelIndex;

+ (void)setDeathCountDataWithLevelIndex:(NSInteger)levelIndex;

+ (void)setLevelDeathCountDataWithLevelIndex:(NSInteger)levelIndex;

@end
