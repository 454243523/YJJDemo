//
//  UIView+Animations.h
//  Ting
//
//  Created by Aufree on 11/23/15.
//  Copyright © 2015 Ting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)
/*!
 *  @brief 按钮动画
 */
- (void)startDuangAnimation;
- (void)startTransitionAnimation;
/*!
 *  @brief 旋转
 */
- (void)startRotateAnimation;
@end