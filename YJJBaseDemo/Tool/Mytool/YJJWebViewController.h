//
//  YJJWebViewController.h
//  WebView返回上一页
//
//  Created by TingLi on 2016/10/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#define kBottomH kWindowHFor6(80)
@interface YJJWebViewController : UIViewController
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) WKWebView *webview;
@end
