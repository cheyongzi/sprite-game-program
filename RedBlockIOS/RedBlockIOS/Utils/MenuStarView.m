//
//  MenuStarView.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/6/28.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "MenuStarView.h"

@implementation MenuStarView

- (id)initWithFrame:(CGRect)frame withStar:(int)starCount {
    if (self = [super initWithFrame:frame]) {
        [self initInterfaceWithStar:starCount];
    }
    return self;
}

- (void)initInterfaceWithStar:(int)starCount {
    
    int space = (self.frame.size.width-15-10*3)/4;
    
    if (starCount > 0) {
        for (int i = 0; i<starCount; i++) {
            UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(8+(10+space)*i+space, 0, 10, 10)];
            starImg.image = [UIImage imageNamed:@"menuStar.png"];
            [self addSubview:starImg];
        }
        
        if (starCount < 3) {
            for (int i = starCount; i<3; i++) {
                UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(8+(10+space)*i+space, 0, 10, 10)];
                starImg.image = [UIImage imageNamed:@"noStar.png"];
                [self addSubview:starImg];
            }
        }
    }else{
        for (int i = 0; i<3; i++) {
            UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(8+(10+space)*i+space, 0, 10, 10)];
            starImg.image = [UIImage imageNamed:@"noStar.png"];
            [self addSubview:starImg];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
