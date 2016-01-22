//
//  AppDelegate.m
//  RedBlockIOS
//
//  Created by cyzcj on 15/4/1.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonSceneUtils.h"
#import "Utils.h"
#import "MenuViewController.h"
#import "IAPUtil.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IAPUtil *iapUtil = [IAPUtil sharedHelper];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:iapUtil];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:DEATH_COUNT]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:DEATH_COUNT];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MAX_ONCE_LEVEL]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MAX_ONCE_LEVEL];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:COMPLETE_LEVEL]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:COMPLETE_LEVEL];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:LEVEL_STAR]) {
        NSMutableArray *mulArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<30; i++) {
            [mulArray addObject:@"Bad"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:mulArray forKey:LEVEL_STAR];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:LEVEL_DEATH]) {
        NSMutableArray *mulArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<30; i++) {
            [mulArray addObject:@"0"];
        }
        [[NSUserDefaults standardUserDefaults] setObject:mulArray forKey:LEVEL_DEATH];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:MUSIC_STATUS]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:MUSIC_STATUS];
        
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:SOUND_STATUS]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:SOUND_STATUS];
    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:CLEAR_PROS];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [self.window makeKeyAndVisible];
//    MenuViewController *menuViewController = [[MenuViewController alloc] init];
//    self.window.rootViewController = menuViewController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}



@end
