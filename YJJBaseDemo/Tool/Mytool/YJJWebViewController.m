//
//  YJJWebViewController.m
//  WebView返回上一页
//
//  Created by TingLi on 2016/10/26.
//  Copyright © 2016年 zws. All rights reserved.
//

#import "YJJWebViewController.h"

@interface YJJWebViewController ()<UIWebViewDelegate>

@end

@implementation YJJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    if (self.url) {
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    
    [Factory addBackItemToVC:self];
    
     [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)observeValueForKeyPath:(NSString* )keyPath ofObject:(id)object change:(NSDictionary* )change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
    } else if ([keyPath isEqualToString:@"title"]) {
        
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (self.webview.title.length > 0) {
            self.title = self.webview.title;
        }
        
    
        if (self.webview.estimatedProgress == 1) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else {
        
        }
    }
    
}

-(WKWebView *)webview
{
    if (_webview == nil) {
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        
        // 自适应屏幕宽度js
        
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        // 添加自适应屏幕宽度js调用的方法
        WKUserContentController *wkUController = [[WKUserContentController alloc]init];
        [wkUController addUserScript:wkUserScript];
        wkWebConfig.userContentController = wkUController;
        _webview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:wkWebConfig];
        _webview.allowsBackForwardNavigationGestures = YES;
        _webview.scrollView.showsHorizontalScrollIndicator = NO;
        _webview.backgroundColor = [UIColor whiteColor];
    }
    return _webview;
}
@end
