//
//  UIView+Shape.h
//  KKDJ
//
//  Created by TingLi on 16/9/13.
//  Copyright © 2016年 TingLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Shape)
/*!
 *  @brief 设置毛玻璃
 */
-(void)addGlassWithFrame:(CGRect)frame;
/*!
 *  @brief 添加下划线
 */
-(void)addLineForColor:(UIColor*)color;
/*!
 *  @brief 设置左右半圆
 */
-(void)addViewForRouned:(NSInteger)type;
@end
