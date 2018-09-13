//
//  UILabel+YJJ.m
//  CaiFuChi
//
//  Created by TingLi on 2017/2/10.
//  Copyright © 2017年 TingLi. All rights reserved.
//

#import "UILabel+YJJ.h"

@implementation UILabel (YJJ)
-(void)setStockStringNew:(NSString *)str
{
    if ([str isKindOfClass:[NSNull class]]) {
        self.text = @"";
        return;
    }
    self.text = str;

    if ([self isPureFloat:str]) {
        if ([str floatValue] >= 0) {
            self.textColor = [UIColor redColor];
        }else{
            self.textColor = kColorStockD;
        }
        
    }else if([str containsString:@"%"]){
        if ([str containsString:@"-"]) {
			self.textColor = kColorStockD;
        }else{
            self.textColor = [UIColor redColor];
        }
    }else{
        self.textColor = [UIColor blackColor];
    }
    
}
-(void)setStockString:(NSString *)str type:(NSInteger)type
{
    self.text = str;
    if ([str floatValue] >= 0) {
        self.textColor = [UIColor redColor];
    }else{
        self.textColor = kColorStockD;
    }
    switch (type) {
        case 1:
            //显示两位小数点
            self.text = [NSString stringWithFormat:@"%.2f",[str floatValue]];
            break;
        case 2:
        	//显示两位小数点且显示百分号
            self.text = [NSString stringWithFormat:@"%.2f%%",[str floatValue]];
            break;
        
        case 3:
            //显示带亿
            self.text = [NSString stringWithFormat:@"%@亿",str];
            break;

        case 4:
        {
            //显示持股状态
            if ([str containsString:@"持"]) {
                self.textColor = kColorStockH;
            }else if ([str containsString:@"损"]){
                self.textColor = kColorStockD;
            }else if ([str containsString:@"盈"]){
                self.textColor = [UIColor redColor];
            }
        }
            break;

        case 5:
            //显示带财富币
            self.text = [NSString stringWithFormat:@"%@财富币",str];
            break;
        case 6:
            self.textColor = [UIColor blackColor];
            break;
        case 7:
            
            self.textColor = [UIColor whiteColor];
            NSInteger value1 = [str integerValue];
            if (value1 <= 30) {
                self.backgroundColor = kColor_red;
                self.text = @"可能ST";
            }else if (value1 <= 50){
                self.backgroundColor = kColor_yellow;
                self.text = @"危险";
            }else if (value1 <= 75){
                self.backgroundColor = kColor_blue;
                self.text = @"正常";
            }else{
                self.backgroundColor = kColor_green;
                self.text = @"优秀";
            }
            kViewRadius(self, 5);
            break;
        case 8:
            self.textColor = [UIColor whiteColor];
            NSInteger value = [str integerValue];
            if (value <= 5) {
                self.backgroundColor = kColor_red;
                self.text = @"不控";
            }else if (value <= 13){
                self.backgroundColor = kColor_yellow;
                self.text = @"轻度";
            }else if (value <= 36){
                self.backgroundColor = kColor_blue;
                self.text = @"中度";
            }else{
                self.backgroundColor = kColor_green;
                self.text = @"高度";
            }
            kViewRadius(self, 5);
            break;
        default:
            self.textColor = [UIColor blackColor];
            break;
    }
}

-(void)numberStrForColor:(UIColor *)color str:(NSString *)str
{
    self.attributedText = [self changeNumberColorFor:str Color:color];
}
-(NSAttributedString *)changeNumberColorFor:(NSString *)str Color:(UIColor *)color
{
    //下面是要变色的字符串  需要NSMutableAttributedString字体
    
    NSMutableAttributedString*AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //下面是要变色的字符串
    
    NSString*nsstring = [NSString stringWithFormat:@"%@",AttributedStr];
    
    // 取出字符串长度做循环
    
    for(int i =0; i < [nsstring length]; ++i) {
        
        // 取出第几位
        
        int a = [nsstring characterAtIndex:i];
        
        //判断是否为数字
        NSRange rang = [nsstring rangeOfString:@"￥"];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
         
                              value:color
         
                              range:rang];
        if(isdigit(a)){
            
            //是
            
            NSLog(@"%d",i);
            
            //就让第i位变色
            
//            [AttributedStr addAttribute:NSFontAttributeName
//             
//                                  value:[UIFont systemFontOfSize:kWindowWFor6(28)]
//             
//                                  range:NSMakeRange(i,1)];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:color
             
                                  range:NSMakeRange(i,1)];
            
        }else{
            
            NSLog(@"%d",i);
            
        }
    }
    return AttributedStr;
}
- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end
