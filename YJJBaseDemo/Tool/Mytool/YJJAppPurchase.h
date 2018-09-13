//
//  YJJAppPurchase.h
//  QFDJ2
//
//  Created by TingLi on 2016/11/23.
//  Copyright © 2016年 TingLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJJAppPurchase : NSObject
@property (nonatomic,strong) NSString *orderID;
@property (nonatomic,strong) NSString *productID;

+(void)startPurchaseWith:(NSString *)orderid product:(NSString *)product;

+(void)addDelegate;
+(void)removeDelegate;

+ (instancetype)sharedInstance;

-(void)checkSev;
@end
