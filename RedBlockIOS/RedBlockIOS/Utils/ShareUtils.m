//
//  ShareUtils.m
//  RedBlockIOS
//
//  Created by che on 15/6/30.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "ShareUtils.h"
#import "WXApi.h"

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
    BOOL wxApi = [WXApi registerApp:@"wxbc356d5dba3c9ddc"];
    
    if ([WXApi isWXAppInstalled]) {
        if (wxApi) {
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"Crazy Block虐我千万遍,我仍待她如初恋";
            message.description = @"虐心之作,从未有过的高度,赶快与我一起体验吧";
            
            [message setThumbData:UIImagePNGRepresentation([UIImage imageNamed:@"icon-180.png"])];
            
            WXWebpageObject *imgObject = [WXWebpageObject object];
            
            imgObject.webpageUrl = @"https://itunes.apple.com/cn/app/id1009641981?mt=8";
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
    BOOL wxApi = [WXApi registerApp:@"wxbc356d5dba3c9ddc"];
    if ([WXApi isWXAppInstalled]) {
        if (wxApi) {
            SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"Crazy Block虐我千万遍,我仍待她如初恋";
            message.description = @"虐心之作,从未有过的高度,赶快与我一起体验吧";
            
            [message setThumbData:UIImagePNGRepresentation([UIImage imageNamed:@"icon-180.png"])];
            
            WXWebpageObject *imgObject = [WXWebpageObject object];
            
            imgObject.webpageUrl = @"https://itunes.apple.com/cn/app/id1009641981?mt=8";
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
    
}

- (void)shareToTweeter {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
