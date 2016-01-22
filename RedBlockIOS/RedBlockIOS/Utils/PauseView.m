//
//  PauseView.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/9.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "PauseView.h"
#import "Utils.h"

@implementation PauseView

+(instancetype)initWithLevelIndex:(NSInteger)levelIndex {
//    static PauseView *pauseView;
//    static dispatch_once_t once_t;
//    dispatch_once(&once_t, ^{
//        pauseView = [[self alloc] init];
//    });
    PauseView *pauseView = [[self alloc] init];
    return pauseView;
}

- (id)init {
    if (self = [super init]) {
        [self initInterface];
    }
    return self;
}

- (void)initInterface {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.3;
    [self addSubview:backgroundView];
    
    
    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-196, -177, 391, 177)];
    backgroundImg.image = [UIImage imageNamed:@"pauseBack.png"];
    backgroundImg.userInteractionEnabled = YES;
    [self addSubview:backgroundImg];
    
    UIButton *resumeBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 70, 68, 70)];
    [resumeBtn setImage:[UIImage imageNamed:@"resumeBtn.png"] forState:UIControlStateNormal];
    [resumeBtn addTarget:self action:@selector(resumeAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImg addSubview:resumeBtn];
    
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(backgroundImg.frame.size.width/2-34, 70, 68, 70)];
    [settingBtn setImage:[UIImage imageNamed:@"settingBtn.png"] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImg addSubview:settingBtn];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(backgroundImg.bounds.size.width-108, 70, 68, 70)];
    [menuBtn setImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImg addSubview:menuBtn];
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveLinear animations:^{
        backgroundImg.center = self.center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)resumeAction:(id)sender {
    [self.pauseDelegate resumeGame];
}

- (void)menuAction:(id)sender {
    [self.pauseDelegate backToMenu];
}

- (void)settingAction:(id)sender {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
