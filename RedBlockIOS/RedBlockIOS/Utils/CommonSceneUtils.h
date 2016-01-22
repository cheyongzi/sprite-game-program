//
//  CommonUtils.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKScene+Unarchive.h"

@interface CommonSceneUtils : NSObject

+(id)shareInstance;

- (SKScene*)createSceneWithLevel:(NSInteger)levelIndex;

@end
