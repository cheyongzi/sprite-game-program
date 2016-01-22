//
//  IAPUtil.h
//  RedBlockIOS
//
//  Created by che on 15/7/6.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MBProgressHUD.h"

@interface IAPUtil : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    MBProgressHUD *progressHud;
}
+(id)sharedHelper;

-(void)requestProductData;

@end
