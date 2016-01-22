//
//  MenuViewController.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/5/10.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "MenuViewController.h"
#import "Utils.h"
#import "GameViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "MenuStarView.h"
#import "ShareUtils.h"
#import "SettingsView.h"
#import "PlayerUtil.h"
#import "ShareView.h"
#import "MBProgressHUD.h"

@interface MenuViewController ()<GADBannerViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    UIPageControl   *pageControl;
    GADBannerView   *bannerView;
    
    int             completedLevelIndex;
    
    UIImageView     *menuBackImg;
    
    NSArray         *starArray;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backgroundImg.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backgroundImg];
    
    menuBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x-186, -250, 371 , 250)];
    menuBackImg.image = [UIImage imageNamed:@"menuBack.png"];
    //menuBackImg.center = self.view.center;
    menuBackImg.userInteractionEnabled = YES;
    [self.view addSubview:menuBackImg];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 0, 361, 250)];
    myScrollView.backgroundColor = [UIColor clearColor];
    myScrollView.pagingEnabled = YES;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(3*(menuBackImg.frame.size.width-10), menuBackImg.frame.size.height);
    myScrollView.delegate = self;
    [menuBackImg addSubview:myScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    pageControl.center = CGPointMake(menuBackImg.frame.size.width/2, menuBackImg.frame.size.height-20);
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [menuBackImg addSubview:pageControl];
    
    SettingsView *settingsView = [[SettingsView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-233, 48, 213)];
    [self.view addSubview:settingsView];
    
    ShareView   *shareView = [[ShareView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-68, SCREEN_HEIGHT-183, 48, 163)];
    [self.view addSubview:shareView];
    
//    bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//    bannerView.rootViewController = self;
//    [self.view addSubview:bannerView];
//    bannerView.adUnitID = @"ca-app-pub-8215383144419477/6803945347";
//    bannerView.delegate = self;
//    [bannerView loadRequest:[self adRequest]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadButtonState];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([@"Y" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_STATUS]]) {
        [[PlayerUtil shareInstance] playBackground];
    }
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:2 options:UIViewAnimationOptionCurveLinear animations:^{
        menuBackImg.center = self.view.center;
    } completion:^(BOOL finished) {
        
    }];
}

- (UIButton*)buttonWithPosition:(CGPoint)position withTag:(int)tag {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(position.x, position.y, 53, 60)];
    [button setTitle:[NSString stringWithFormat:@"%d",tag+1] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:30]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(-10, 0, 0, 0)];
    if (tag < [[[NSUserDefaults standardUserDefaults] objectForKey:COMPLETE_LEVEL] intValue]) {
        [button setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        MenuStarView *starView;
        if ([@"Bad" isEqualToString:[starArray objectAtIndex:tag]]) {
            starView = [[MenuStarView alloc] initWithFrame:CGRectMake(0, 40, 53, 10) withStar:0];
        }else if ([@"Good" isEqualToString:[starArray objectAtIndex:tag]]){
            starView = [[MenuStarView alloc] initWithFrame:CGRectMake(0, 40, 53, 10) withStar:1];
        }else if ([@"Great" isEqualToString:[starArray objectAtIndex:tag]]){
            starView = [[MenuStarView alloc] initWithFrame:CGRectMake(0, 40, 53, 10) withStar:2];
        }else {
            starView = [[MenuStarView alloc] initWithFrame:CGRectMake(0, 40, 53, 10) withStar:3];
        }
        [button addSubview:starView];
    }else{
        UIImageView *lockImg = [[UIImageView alloc] initWithFrame:CGRectMake(-4, -5, 16, 20)];
        lockImg.image = [UIImage imageNamed:@"lock.png"];
        [button addSubview:lockImg];
        [button setBackgroundImage:[UIImage imageNamed:@"menuLock.png"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
    }
    button.tag = 1000+tag;
    return button;
}

- (void)buttonClick:(id)sender {
    NSInteger levelIndex = [(UIButton*)sender tag]-1000;
    GameViewController *gameController = [[GameViewController alloc] initWithLevelIndex:levelIndex];
    [self.navigationController pushViewController:gameController animated:NO];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / myScrollView.frame.size.width;
    pageControl.currentPage = page;
}

#pragma mark UIPageControlClickAction
- (void)changePage:(id)sender {
    NSInteger page = pageControl.currentPage;
    [myScrollView setContentOffset:CGPointMake(myScrollView.frame.size.width*page, 0)];
}

//#pragma mark GADBannerViewDelegate
//- (GADRequest*)adRequest {
//    GADRequest *request = [GADRequest request];
//    request.testDevices = @[ @"320df9d95be7857c0fa98ce6b645bd68" ];
//    return request;
//}
//- (void)adViewDidReceiveAd:(GADBannerView *)view {
//    
//}
//
//- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"%@",error.description);
//}

#pragma mark ReloadButtonState
- (void)reloadButtonState {
    completedLevelIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:COMPLETE_LEVEL] intValue];
    starArray = [[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_STAR];
    for (UIView *view in [myScrollView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    for (int z = 0; z<3; z++) {
        for (int i = 0; i<2; i++) {
            for (int j = 0; j<5; j++) {
                float hSpace = (361-53*5)/6;
                float vSpace = (180-60*2)/3;
                UIButton *levelButton = [self buttonWithPosition:CGPointMake(z*myScrollView.frame.size.width+hSpace+j*(53+hSpace), 70+i*(vSpace+60)) withTag:z*10+i*5+j];
                [myScrollView addSubview:levelButton];
            }
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
