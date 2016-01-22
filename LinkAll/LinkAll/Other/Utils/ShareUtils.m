//
//  ShareUtils.m
//  RedBlockIOS
//
//  Created by che on 15/6/30.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "ShareUtils.h"
#import "WXApi.h"
#import <Social/Social.h>

@implementation ShareUtils

+ (instancetype)shareInstance {
    static ShareUtils *shareUtils;
    static dispatch_once_t once_t;
    
    dispatch_once(&once_t, ^{
        shareUtils = [[ShareUtils alloc] init];
    });
    return shareUtils;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)shareToFriendZone {
    BOOL wxApi = [WXApi registerApp:@"wxae12f632a75885b5"];
    
    if ([WXApi isWXAppInstalled]) {
        if (wxApi) {
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"智力大考验";
            message.description = @"连接每个场景中的所有节点，赶快和我一起体验吧";
            
            [message setThumbData:UIImagePNGRepresentation([UIImage imageNamed:@"icon-180.png"])];
            
            WXWebpageObject *imgObject = [WXWebpageObject object];
            
            imgObject.webpageUrl = @"https://itunes.apple.com/cn/app/id1059276346?mt=8";
            message.mediaObject = imgObject;
            req.message = message;
            req.bText = NO;
            req.scene = WXSceneTimeline;
            
            [WXApi sendReq:req];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"微信分享注册失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"未安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)shareToWeChat {
    BOOL wxApi = [WXApi registerApp:@"wxae12f632a75885b5"];
    if ([WXApi isWXAppInstalled]) {
        if (wxApi) {
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"智力大考验";
            message.description = @"连接每个场景中的所有节点，赶快和我一起体验吧";
            
            [message setThumbData:UIImagePNGRepresentation([UIImage imageNamed:@"icon-180.png"])];
            
            WXWebpageObject *imgObject = [WXWebpageObject object];
            
            imgObject.webpageUrl = @"https://itunes.apple.com/cn/app/id1059276346?mt=8";
            message.mediaObject = imgObject;
            req.message = message;
            req.bText = NO;
            req.scene = WXSceneSession;
            
            [WXApi sendReq:req];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"微信分享注册失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"未安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)shareToFaceBook {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController     *faceController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [faceController setInitialText:@"https://itunes.apple.com/cn/app/id1059276346?mt=8"];
        [[[UIApplication sharedApplication].windows lastObject].rootViewController presentViewController:faceController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Account" message:@"Please login to a Facebook account to share." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)shareToTweeter {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController     *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterController setInitialText:@"https://itunes.apple.com/cn/app/id1059276346?mt=8"];
        [[[UIApplication sharedApplication].windows lastObject].rootViewController presentViewController:twitterController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Account" message:@"Please login to a Twitter account to share." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

@end
