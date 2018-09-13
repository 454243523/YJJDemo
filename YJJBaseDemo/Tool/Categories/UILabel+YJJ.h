//
//  UILabel+YJJ.h
//  CaiFuChi
//
//  Created by TingLi on 2017/2/10.
//  Copyright © 2017年 TingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YJJ)

/**
 定义显示格式

 @param str 显示文字
 @param type 显示格式
 */
-(void)setStockString:(NSString *)str type:(NSInteger)type;
-(void)setStockStringNew:(NSString *)str;
//设置字符串中间变色
-(void)numberStrForColor:(UIColor *)color str:(NSString *)str;
@end
