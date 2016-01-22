//
//  IAPUtil.m
//  RedBlockIOS
//
//  Created by che on 15/7/6.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "IAPUtil.h"
#import "MBProgressHUD.h"
#import "Utils.h"

@implementation IAPUtil

static IAPUtil * _sharedHelper;

+ (id)sharedHelper {
    
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[IAPUtil alloc] init];
    return _sharedHelper;
}

-(id)init
{
    if ((self = [super init])) {
    }
    return self;
}

-(void)requestProductData
{
    NSString *productId = @"com.cheyongzi.RedBlock.ClearBlock";
    NSArray *product = [[NSArray alloc] initWithObjects:productId, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers: nsset];
    request.delegate=self;
    [request start];
}

#pragma mark SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray  *myProduct = response.products;
    
    SKProduct *product = nil;
    
    for(SKProduct *p in myProduct){
        if ([p.productIdentifier isEqualToString:@"com.cheyongzi.RedBlock.ClearBlock"]) {
            product = p;
            break;
        }
    }
    
    if (product != nil) {
        //发送购买请求
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

#pragma mark SKRequestDelegate
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    //产品信息查询错误，给出相应的提示信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BuyFailed" object:nil];
}

-(void) requestDidFinish:(SKRequest *)request
{
    //产品信息查询完成
}

#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions//交易结果
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
                break;
            case SKPaymentTransactionStatePurchasing:
                break;
            default:
                break;
        }
    }
}

-(void) paymentQueueRestoreCompletedTransactionsFinished: (SKPaymentTransaction *)transaction{
    //这里只针对非消耗型产品进行Restore返回正确的回调
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    //这里指针对非消耗型产品进行Restore返回错误的回调。
}

#pragma mark Transaction Result Method
- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    //支付成功针对交易进行处理
    int clearProsNum = [[[NSUserDefaults standardUserDefaults] objectForKey:CLEAR_PROS] intValue]+2;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:clearProsNum] forKey:CLEAR_PROS];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BuySuccess" object:nil];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BuyFailed" object:nil];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

#pragma mark ===================
-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
