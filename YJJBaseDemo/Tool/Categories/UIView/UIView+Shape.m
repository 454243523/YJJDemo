//
//  UIView+Shape.m
//  KKDJ
//
//  Created by TingLi on 16/9/13.
//  Copyright © 2016年 TingLi. All rights reserved.
//

#import "UIView+Shape.h"

@implementation UIView(Shape)
-(void)addGlassWithFrame:(CGRect)frame
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:frame]; // toolBar的frame就是imageView的bounds。
    toolBar.barStyle = UIBarStyleDefault;
//    toolBar.alpha = 0.95;
    [self addSubview:toolBar];
}
-(void)addLineForColor:(UIColor*)color
{
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = color;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(1);
    }];

}
-(void)addViewForRouned:(NSInteger)type
{
    UIBezierPath *maskPath;
    if (type == 1) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerBottomLeft) cornerRadii:CGSizeMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    }else{
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight) cornerRadii:CGSizeMake(self.bounds.size.width/2, self.bounds.size.height/2)];
    }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
    
}
@end
