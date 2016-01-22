//
//  GameViewController.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "GameViewController.h"
#import "SKScene+Unarchive.h"
#import "BaseScene.h"
#import "UserDataUtil.h"
#import "PauseView.h"
#import "LevelClearView.h"
#import "IAPUtil.h"
#import "MBProgressHUD.h"

@interface GameViewController ()<PauseViewDelegate,LevelClearDelegate>
{
    int   currentLevelIndex;
    BaseScene   *currentBaseScene;
    
    UILabel     *deathCountLabel;
    UILabel     *levelIndexLabel;
    
    PauseView   *pauseView;
    LevelClearView *clearView;
    
    MBProgressHUD   *progressHud;
    
    UIButton    *skipBtn;
}
@end

@implementation GameViewController

- (id)initWithLevelIndex:(NSInteger)levelIndex {
    if (self = [super init]) {
        currentLevelIndex = (int)levelIndex;
    }
    return self;
}

- (void)viewWillLayoutSubviews {
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    //skView.showsPhysics = YES;
    // Create and configure the scene.
    currentBaseScene = [BaseScene createScenWithLevelIndex:currentLevelIndex];
    currentBaseScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [self createDirectionButton];

    [self initLeveLabel];
    
    // Present the scene.
    [skView presentScene:currentBaseScene];
}

- (void)loadView {
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    SKView *skView = [[SKView alloc] initWithFrame:applicationFrame];
    self.view = skView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartGame:) name:Restart_Noti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextLevelGame:) name:Next_Noti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForend:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buySuccess:) name:@"BuySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyFailed:) name:@"BuyFailed" object:nil];
}

#pragma mark Level Control Method

- (void)restartGame:(NSNotification*)notification {
    [UserDataUtil setDeathCountDataWithLevelIndex:currentLevelIndex];
    [UserDataUtil setLevelDeathCountDataWithLevelIndex:currentLevelIndex];
    [self startGame];
}

- (void)nextLevelGame:(NSNotification*)notification {
    [self completedAction];
}

#pragma mark LevelClearDelegate
- (void)restartGame {
    [clearView removeFromSuperview];
    [currentBaseScene removeAllActions];
    [currentBaseScene removeAllChildren];
    [self startGame];
}

- (void)nextLevelGame {
    [clearView removeFromSuperview];
    [currentBaseScene removeAllActions];
    [currentBaseScene removeAllChildren];
    currentLevelIndex += 1;
    [self startGame];
}

- (void)menuAction {
    [self backToMenu];
}

#pragma mark Present Scene
- (void)startGame {
    [self reloadLabelText];
    currentBaseScene = [BaseScene createScenWithLevelIndex:currentLevelIndex];
    currentBaseScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [(SKView*)self.view presentScene:currentBaseScene];
}

#pragma mark 创建方向按钮
- (void)createDirectionButton {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, SCREEN_HEIGHT-160, 70, 70);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"leftArrow.png"] forState:UIControlStateNormal];
    leftButton.tag = LEFT_MOVE_TAG;
    [leftButton addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchDown];
    [leftButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:leftButton];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(10, SCREEN_HEIGHT-80, 70, 70);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"rightArrow.png"] forState:UIControlStateNormal];
    rightButton.tag = RIGHT_MOVE_TAG;
    [rightButton addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchDown];
    [rightButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:rightButton];
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-160, 70, 70);
    [upButton setBackgroundImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
    upButton.layer.cornerRadius = 30;
    upButton.tag = UP_MOVE_TAG;
    [upButton addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchDown];
    [upButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [upButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:upButton];
    
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-80, 70, 70);
    [downButton setBackgroundImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
    downButton.tag = DOWN_MOVE_TAG;
    [downButton addTarget:self action:@selector(buttonDownAction:) forControlEvents:UIControlEventTouchDown];
    [downButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpInside];
    [downButton addTarget:self action:@selector(buttonUpAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:downButton];
}

#pragma mark Direction Button Action
#pragma mark 按钮按下的事件
- (void)buttonDownAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case LEFT_MOVE_TAG:
            currentBaseScene.leftButtonPressDown = YES;
            break;
        case RIGHT_MOVE_TAG:
            currentBaseScene.rightButtonPressDown = YES;
            break;
        case UP_MOVE_TAG:
            currentBaseScene.upButtonPressDown = YES;
            break;
        case DOWN_MOVE_TAG:
            currentBaseScene.downButtonPressDown = YES;
            break;
        default:
            break;
    }
}

#pragma mark 按钮弹起的事件
- (void)buttonUpAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    switch (button.tag) {
        case LEFT_MOVE_TAG:
            currentBaseScene.leftButtonPressDown = NO;
            break;
        case RIGHT_MOVE_TAG:
            currentBaseScene.rightButtonPressDown = NO;
            break;
        case UP_MOVE_TAG:
            currentBaseScene.upButtonPressDown = NO;
            break;
        case DOWN_MOVE_TAG:
            currentBaseScene.downButtonPressDown = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark LevelLabelInit
- (void)initLeveLabel {
    UIButton *pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 40, 40)];
    [pauseBtn setBackgroundImage:[UIImage imageNamed:@"pauseBtn.png"] forState:UIControlStateNormal];
    [pauseBtn addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pauseBtn];
    
    levelIndexLabel = [self labelWithFrame:CGRectMake(SCREEN_WIDTH/2-SCREEN_WIDTH/3, 5, SCREEN_WIDTH/3, 30) withText:[NSString stringWithFormat:@"Level:%d/30",currentLevelIndex+1]];
    [self.view addSubview:levelIndexLabel];
    
    NSString *deathCountStr = [[NSUserDefaults standardUserDefaults] objectForKey:DEATH_COUNT];
    deathCountLabel = [self labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 5, SCREEN_WIDTH/3, 30) withText:[NSString stringWithFormat:@"Death:%@",deathCountStr]];
    [self.view addSubview:deathCountLabel];
    
    int skipLevelNum = [[[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS] intValue];
    skipBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-95, 5, 70, 35)];
    skipBtn.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [skipBtn setTitle:[NSString stringWithFormat:@"Skip x%d",skipLevelNum] forState:UIControlStateNormal];
    [skipBtn setBackgroundImage:[UIImage imageNamed:@"skipBtn.png"] forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skipBtn];
}

- (void)reloadLabelText {
    NSString *deathCountStr = [[NSUserDefaults standardUserDefaults] objectForKey:DEATH_COUNT];
    deathCountLabel.text = [NSString stringWithFormat:@"Death:%@",deathCountStr];
    
    levelIndexLabel.text = [NSString stringWithFormat:@"Level:%d/30",currentLevelIndex+1];
}

#pragma mark PauseGame
- (void)pauseGame {
    //暂停游戏
    if (!currentBaseScene.isPaused) {
        currentBaseScene.paused = YES;
        [self addPauseView];
    }
}

- (void)addPauseView {
    if (!pauseView) {
        pauseView = [PauseView initWithLevelIndex:currentLevelIndex+1];
        pauseView.pauseDelegate = self;
        [self.view insertSubview:pauseView atIndex:1000];
    }
}

- (void)skipAction {
    [self pauseGame];
    int skipLevelNum = [[[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS] intValue];
    if (skipLevelNum == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"levelBuy", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancelButton", nil) otherButtonTitles:NSLocalizedString(@"buyButton", nil), nil];
        alertView.tag = 1001;
        [alertView show];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"levelClear", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"cancelButton", nil) otherButtonTitles:NSLocalizedString(@"confirmButton", nil), nil];
        alertView.tag = 1002;
        [alertView show];
    }
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if (alertView.tag == 1001) {
            [[IAPUtil sharedHelper] requestProductData];
            progressHud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
            progressHud.labelText = @"购买中...";
            [progressHud show:YES];
        }else {
            int clearProsNum = [[[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS] intValue]-1;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:clearProsNum] forKey:CLEAR_PROS];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [skipBtn setTitle:[NSString stringWithFormat:@"Skip x%d",clearProsNum] forState:UIControlStateNormal];
            
            if (pauseView) {
                [pauseView removeFromSuperview];
                pauseView.pauseDelegate = nil;
                pauseView = nil;
            }
            
            [self completedAction];
        }
    }
}

- (void)completedAction {
    [UserDataUtil setCompleteLevelDataWithLevelIndex:currentLevelIndex];
    NSMutableArray *mulArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_DEATH] mutableCopy];
    int deathCount = [[mulArray objectAtIndex:currentLevelIndex] intValue];
    NSMutableArray *starArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:LEVEL_STAR] mutableCopy];
    if (deathCount < 5) {
        [starArray replaceObjectAtIndex:currentLevelIndex withObject:@"Perfect"];
    }else if (deathCount <10) {
        [starArray replaceObjectAtIndex:currentLevelIndex withObject:@"Great"];
    }else{
        [starArray replaceObjectAtIndex:currentLevelIndex withObject:@"Good"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:starArray forKey:LEVEL_STAR];
    [[NSUserDefaults standardUserDefaults] synchronize];
    currentBaseScene.paused = YES;
    clearView = [[LevelClearView alloc] initWithCurrentLevelIndex:currentLevelIndex];
    clearView.clearDelegate = self;
    [self.view addSubview:clearView];
}

#pragma mark PauseViewDelegate
- (void)resumeGame {
    //继续游戏
    if (pauseView) {
        currentBaseScene.paused = NO;
        
        [pauseView removeFromSuperview];
        pauseView.pauseDelegate = nil;
        pauseView = nil;
    }
}

- (void)backToMenu {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark InitLabel
- (UILabel*)labelWithFrame:(CGRect)frame withText:(NSString*)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"Chalkduster" size:20];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark ActiveNotification
- (void)enterForend:(NSNotification*)notification {
    [self pauseGame];
}

#pragma mark BuyNotification
- (void)buySuccess:(NSNotification*)notification {
    int skipLevelNum = [[[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS] intValue];
    [skipBtn setTitle:[NSString stringWithFormat:@"Skip x%d",skipLevelNum] forState:UIControlStateNormal];
    progressHud.labelText = @"购买成功";
    [progressHud hide:YES afterDelay:2.0f];
}

- (void)buyFailed:(NSNotification*)notification {
    progressHud.labelText = @"购买失败";
    [progressHud hide:YES afterDelay:2.0f];
}

#pragma mark =================

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
