//
//  LevelClearView.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/6/28.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "LevelClearView.h"
#import "Utils.h"

@interface LevelClearView ()
{
    UIImageView *backgroundImg;
}
@end

@implementation LevelClearView

- (instancetype)initWithCurrentLevelIndex:(int)currentLevelIndex
{
    if (self = [super init]) {
        [self initInterfaceWithLevelIndex:currentLevelIndex];
    }
    return self;
}

- (void)initInterfaceWithLevelIndex:(int)levelIndex {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.3;
    [self addSubview:backgroundView];
    
    
    backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-145, -318, 290, 318)];
    backgroundImg.image = [UIImage imageNamed:@"levelClearBack.png"];
    backgroundImg.userInteractionEnabled = YES;
    [self addSubview:backgroundImg];
    
    [self initStarViewWith:levelIndex];
    
    [self initButtonWithLevel:levelIndex];
    
    [UIView animateWithDuration:0.5f delay:0.2 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveLinear animations:^{
        backgroundImg.center = self.center;
    } completion:nil];
}

- (void)initStarViewWith:(int)levelIndex {
    NSArray *starArray = [[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_STAR];
    
    UIImageView *star1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 67, 68)];
    star1.image = [UIImage imageNamed:@"leftNoStar.png"];
    [backgroundImg addSubview:star1];
    
    UIImageView *star2 = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundImg.frame.size.width/2-43, 50, 86, 84)];
    star2.image = [UIImage imageNamed:@"middleNoStar.png"];
    [backgroundImg addSubview:star2];
    
    UIImageView *star3 = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundImg.frame.size.width-87, 70, 67, 68)];
    star3.image = [UIImage imageNamed:@"rightNoStar.png"];
    [backgroundImg addSubview:star3];
    
    if ([@"Good" isEqualToString:[starArray objectAtIndex:levelIndex]]) {
        star1.image = [UIImage imageNamed:@"leftStar.png"];
    }else if ([@"Great" isEqualToString:[starArray objectAtIndex:levelIndex]]) {
        star1.image = [UIImage imageNamed:@"leftStar.png"];
        star2.image = [UIImage imageNamed:@"middleStar.png"];
    }else if ([@"Perfect" isEqualToString:[starArray objectAtIndex:levelIndex]]){
        star1.image = [UIImage imageNamed:@"leftStar.png"];
        star2.image = [UIImage imageNamed:@"middleStar.png"];
        star3.image = [UIImage imageNamed:@"rightStar.png"];
    }
    
    UILabel *deathLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, backgroundImg.frame.size.width, 40)];
    deathLabel.textAlignment = NSTextAlignmentCenter;
    NSMutableArray *mulArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_DEATH] mutableCopy];
    int deathCount = [[mulArray objectAtIndex:levelIndex] intValue];
    deathLabel.text = [NSString stringWithFormat:@"Death: %d",deathCount];
    deathLabel.textColor = [UIColor whiteColor];
    deathLabel.font = [UIFont fontWithName:@"Chalkduster" size:40];
    [backgroundImg addSubview:deathLabel];
}

- (void)initButtonWithLevel:(NSInteger)level {
    UIButton *restartButton = [[UIButton alloc] initWithFrame:CGRectMake(20, backgroundImg.frame.size.height-80, 68, 70)];
    [restartButton setImage:[UIImage imageNamed:@"reStartBtn.png"] forState:UIControlStateNormal];
    [restartButton addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImg addSubview:restartButton];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(backgroundImg.frame.size.width/2-34, backgroundImg.frame.size.height-80, 68, 70)];
    [menuButton setImage:[UIImage imageNamed:@"menuBtn.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImg addSubview:menuButton];
    
    if (level<29) {
        UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(backgroundImg.frame.size.width-88, backgroundImg.frame.size.height-80, 68, 70)];
        [nextButton setImage:[UIImage imageNamed:@"forwordBtn.png"] forState:UIControlStateNormal];
        [nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundImg addSubview:nextButton];
    }
}

- (void)restartAction:(id)sender {
    [self.clearDelegate restartGame];
}

- (void)menuAction:(id)sender {
    [self.clearDelegate menuAction];
}

- (void)nextAction:(id)sender {
    [self.clearDelegate nextLevelGame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
