//
//  SKScene+Unarchive.h
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file;

@end