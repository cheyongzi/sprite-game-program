//
//  CommonUtils.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "CommonSceneUtils.h"
#import "GameScene1.h"
#import "GameScene2.h"
#import "GameScene3.h"
#import "GameScene4.h"
#import "GameScene5.h"
#import "GameScene6.h"
#import "GameScene7.h"
#import "GameScene8.h"
#import "GameScene9.h"
#import "GameScene10.h"
#import "GameScene11.h"
#import "GameScene12.h"
#import "GameScene13.h"
#import "GameScene14.h"
#import "GameScene15.h"
#import "GameScene16.h"
#import "GameScene17.h"
#import "GameScene18.h"
#import "GameScene19.h"
#import "GameScene20.h"
#import "GameScene21.h"
#import "GameScene22.h"
#import "GameScene23.h"
#import "GameScene24.h"
#import "GameScene25.h"
#import "GameScene26.h"
#import "GameScene27.h"
#import "GameScene28.h"
#import "GameScene29.h"
#import "GameScene30.h"
#import "GameScene31.h"
#import "GameScene32.h"
#import "GameScene33.h"
#import "GameScene34.h"
#import "GameScene35.h"
#import "GameScene36.h"
#import "GameScene37.h"
#import "GameScene38.h"
#import "GameScene39.h"
#import "GameScene40.h"

#define CURRENT_SCENE(__class__,__name__) [__class__ unarchiveFromFile:__name__]

@interface CommonSceneUtils ()
{
    NSMutableArray *sceneLevelClassArray;
    NSMutableArray *sceneLevelNameArray;
}
@end

@implementation CommonSceneUtils

+(id)shareInstance {
    static CommonSceneUtils *sceneUtils;
    static dispatch_once_t  once_t;
    dispatch_once(&once_t, ^{
        sceneUtils = [[CommonSceneUtils alloc] init];
    });
    return sceneUtils;
}

- (id)init {
    if (self = [super init]) {
        sceneLevelClassArray = [[NSMutableArray alloc] init];
        sceneLevelNameArray = [[NSMutableArray alloc] init];
        for (int i = 1; i<=30; i++) {
            NSString *className = [NSString stringWithFormat:@"GameScene%d",i];
            Class class = NSClassFromString(className);
            [sceneLevelClassArray addObject:class];
            [sceneLevelNameArray addObject:className];
        }
    }
    return self;
}

-(SKScene*)createSceneWithLevel:(NSInteger)levelIndex {
    return CURRENT_SCENE(sceneLevelClassArray[levelIndex], sceneLevelNameArray[levelIndex]);
}

@end
