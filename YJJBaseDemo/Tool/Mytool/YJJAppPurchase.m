//
//  YJJAppPurchase.m
//  QFDJ2
//
//  Created by TingLi on 2016/11/23.
//  Copyright © 2016年 TingLi. All rights reserved.
//

#import "YJJAppPurchase.h"
#import <StoreKit/StoreKit.h>
#import "CFCUserNetManeger.h"

#define kBack_URL [NSString stringWithFormat:@"%@/v2.0/zfapi/applepay/check.asp",kHomeUrl]
@interface YJJAppPurchase ()<SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (nonatomic,strong) NSString * price;
@end
@implementation YJJAppPurchase
+ (instancetype)sharedInstance {
    static YJJAppPurchase *_Purchase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _Purchase = [[YJJAppPurchase alloc]init];
    });
    return _Purchase;
}
+(void)addDelegate
{
    NSLog(@"开启支付监听");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[YJJAppPurchase sharedInstance]];
}
+(void)removeDelegate
{
    NSLog(@"开启支付监听");
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:[YJJAppPurchase sharedInstance]];
}
- (void)dealloc{
    NSLog(@"移除");
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
+(void)startPurchaseWith:(NSString *)orderid product:(NSString *)product
{
    YJJAppPurchase * pay = [YJJAppPurchase sharedInstance];
    pay.orderID = orderid;
    pay.productID = product;
    [pay applePay];
}
#pragma mark - 应用内购买
- (void)applePay
{
    //    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:self.productID];
    }else{
        NSLog(@"不允许程序内付费");
    }
}

//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type,nil];
    [MBProgressHUD showHUDAddedTo:[Factory getCurrentVC].view animated:YES];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}

//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%ld",[product count]);
    
    SKProduct *p = nil;
    NSString *productIdentifier = self.productID;
    for (SKProduct *pro in product) {
        NSLog(@"description %@", [pro description]);
        NSLog(@"title %@", [pro localizedTitle]);
        NSLog(@"localizedDescription %@", [pro localizedDescription]);
        NSLog(@"price %@", [pro price]);
        NSLog(@"productIdentifier %@", [pro productIdentifier]);
        self.price = [NSString stringWithFormat:@"%@",[pro price]];
        if([pro.productIdentifier isEqualToString:productIdentifier]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    
    NSLog(@"-----PurchasedTransaction----");
    
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [ self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
    
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
    [MBProgressHUD hideHUDForView:[Factory getCurrentVC].view animated:YES];
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}

#ifdef DEBUG


//沙盒测试环境验证
#define AppStore @"https://sandbox.itunes.apple.com/verifyReceipt"


#else

//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

#endif

/**
 *  验证购买，避免越狱软件模拟苹果请求达到非法购买问题
 *
 */
-(void)checkSev{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];
    NSLog(@"%@",payload);
    if (self.price == nil) {
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"price"]) {
            return;
        }
        self.price =  [[NSUserDefaults standardUserDefaults] valueForKey:@"price"];
    }
    
    NSString * url = [NSString stringWithFormat:@"%@/api.php?ac=user_addScore",kHomeUrl];
//    NSDictionary *dic = [BaseNetManager getSignWithAC:@"user_addScore" dic:@{@"score":self.price,@"form":payload}];
    [BaseNetManager POST:url parameters:@{@"uid":[ISZUser shareUser].uid,@"token":[ISZUser shareUser].token,@"score":self.price,@"form":receiptString} completionHandler:^(id responseObj, NSError *error) {
        NSLog(@"%@",responseObj);
        BaseModel *model = [BaseModel mj_objectWithKeyValues:responseObj];
        if (model.isSuessResult) {
            [CFCUserNetManeger getUserInfocompletionHandle:^(BOOL isOK, NSError *error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kScore object:nil];
            }];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"price"];
        }
    }];
//    NSData *bodyData = [receiptString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error1=nil;
//    NSMutableURLRequest *requestM1=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:AppStore]];
//    requestM1.HTTPBody=bodyData;
//    requestM1.HTTPMethod=@"POST";
//    NSData *responseData2=[NSURLConnection sendSynchronousRequest:requestM1 returningResponse:nil error:&error1];
//    if (error1) {
//        NSLog(@"验证购买过程中发生错误，错误信息：%@",error1.localizedDescription);
//        [Factory showMiddleHint:@"验证购买过程中发生错误"];
//        return;
//    }
//    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseData2 options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"pay result = %@",dic);
//    if (a) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderid"];
//        if (a == 200) {
//            [Factory showMiddleHint:@"充值成功"];
//        }else{
//            [Factory showMiddleHint:@"充值失败"];
//        }
//    }
    
}
-(void)checkLocation
{
    //从沙盒中获取交易凭证并且拼接成请求体数据
    NSURL *receiptUrl=[[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData=[NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString=[receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];//转化为base64字符串
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    //        NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    //        NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    
    // 发送网络POST请求，对购买凭据进行验证
    NSURL *url = [NSURL URLWithString:AppStore];
    // 国内访问苹果服务器比较慢，timeoutInterval需要长一点
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    
    request.HTTPMethod = @"POST";
    
    // 在网络中传输数据，大多情况下是传输的字符串而不是二进制数据
    // 传输的是BASE64编码的字符串
    /**
     BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
     BASE64是可以编码和解码的
     */
    
//    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //        NSString *encodeStr = [ base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\" : \"%@\"}", receiptString];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = payloadData;
    
    // 提交验证请求，并获得官方的验证JSON结果
    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // 官方验证结果为空
    if (result == nil) {
        NSLog(@"验证失败");
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"location = %@", dict);
    
    if (dict != nil) {
        // 比对字典中以下信息基本上可以保证数据安全
        //     bundle_id&application_version&product_id&transaction_id
        NSLog(@"验证成功");
    }
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    NSLog(@"-----paymentQueue--------");
    [MBProgressHUD hideHUDForView:[Factory getCurrentVC].view animated:YES];
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                //            交易完成
                [self  completeTransaction:transaction];
                
                NSLog(@"-----交易完成 --------");
                
                //                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"" message:@"购买成功" delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                //                [alerView show];
            } break;
            case SKPaymentTransactionStateFailed://交易失败
                
            {
                [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                UIAlertView *alerView2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买失败，请重新尝试购买" delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                [alerView2 show];
            }break;
                
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                NSLog(@"-----已经购买过该商品 --------");
            case SKPaymentTransactionStatePurchasing:
                //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break
                ; default:
                break;
        }
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    NSString * productIdentifier = transaction.payment.productIdentifier;
    NSLog(@"productid:%@",productIdentifier);
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        [[NSUserDefaults standardUserDefaults] setObject:self.price forKey:@"price"];
        [self checkSev];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    NSLog(@"回复购买%@",transaction.transactionIdentifier);
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


@end
