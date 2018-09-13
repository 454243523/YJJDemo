//
//  YJJDefine.h
//  可可DJ
//
//  Created by TingLi on 2018/3/26.
//  Copyright © 2018年 TingLi. All rights reserved.
//

#ifndef YJJDefine_h
#define YJJDefine_h
//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define kWindowHFor6(height)   kWindowH*height/1336 //应用程序的屏幕高度
#define kWindowWFor6(width)   kWindowW*width/640  //应用程序的屏幕宽度

#define YYISiPhoneX [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f&& YYIS_IPHONE
#define YYIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//状态栏高度
#define kStatusBarHeight (CGFloat)(YYISiPhoneX?(44):(20))
// 导航栏高度
#define kNavBarHBelow7 (44)
// 状态栏和导航栏总高度
#define kNavBarHAbove7 (CGFloat)(YYISiPhoneX?(88):(64))
// TabBar高度
#define kTabBarHeight (CGFloat)(YYISiPhoneX?(49+34):(49))
// 顶部安全区域远离高度
#define kTopBarSafeHeight (CGFloat)(YYISiPhoneX?(44):(0))
// 底部安全区域远离高度
#define kBottomSafeHeight (CGFloat)(YYISiPhoneX?(34):(0))
// iPhoneX的状态栏高度差值
#define kTopBarDifHeight (CGFloat)(YYISiPhoneX?(24):(0))

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}
//去掉UItableview headerview黏性
#define kRemoveTableviewSection(tableview) \
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { \
if (scrollView == tableview) \
{ \
CGFloat sectionHeaderHeight = kheightSamll; \
if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) { \
scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0); \
} else if (scrollView.contentOffset.y>=sectionHeaderHeight) { \
scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0); \
} \
} \
} \
//表格下划线颜色
#define kCellSeparatorColor(tableView) [tableView setSeparatorColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2]];
//添加边框
#define kBorderWidthAndColor(view,width,color)    view.layer.borderWidth = width;\
view.layer.borderColor = [color CGColor] ;
//圆角
#define kViewRadius(view,radius) view.layer.cornerRadius = radius;\
view.layer.masksToBounds = YES;

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

//提示字体透明度
#define kplaceholderAlpha(view) [view setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.2] forKeyPath:@"_placeholderLabel.textColor"];
//title字体颜色和大小
#define kTitle(size,color)       [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:color}]
#define kNavBg(nav) [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:kColor_bg andSize:CGSizeMake(kWindowW, 64)] forBarMetrics:UIBarMetricsDefault];
//防止循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//通过RGB设置颜色
#define kRGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

#define kWindowHFor6(height)   kWindowH*height/1336 //应用程序的屏幕高度
#define kWindowWFor6(width)   kWindowW*width/640  //应用程序的屏幕宽度

#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

//通过Storyboard ID 在对应Storyboard中获取场景对象
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}
//去掉UItableview headerview黏性
#define kRemoveTableviewSection(tableview) \
- (void)scrollViewDidScroll:(UIScrollView *)scrollView { \
if (scrollView == tableview) \
{ \
CGFloat sectionHeaderHeight = kheightSamll; \
if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) { \
scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0); \
} else if (scrollView.contentOffset.y>=sectionHeaderHeight) { \
scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0); \
} \
} \
} \
//表格下划线颜色
#define kCellSeparatorColor(tableView) [tableView setSeparatorColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2]];
//添加边框
#define kBorderWidthAndColor(view,width,color)    view.layer.borderWidth = width;\
view.layer.borderColor = [color CGColor] ;
//圆角
#define kViewRadius(view,radius) view.layer.cornerRadius = radius;\
view.layer.masksToBounds = YES;
//title字体颜色和大小
#define kTitle(size,color)       [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:[UIColor color]}]

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

//提示字体透明度
#define kplaceholderAlpha(view) [view setValue:[[UIColor whiteColor] colorWithAlphaComponent:0.2] forKeyPath:@"_placeholderLabel.textColor"];
//title字体颜色和大小
#define kTitle(size,color)       [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size],NSForegroundColorAttributeName:[UIColor color]}]
//防止循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#endif /* YJJDefine_h */
