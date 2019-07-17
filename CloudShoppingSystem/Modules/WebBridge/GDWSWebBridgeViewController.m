//
//  GDWSWebBridgeViewController.m
//  Mall_GDWS
//
//  Created by dengyuchi on 16/7/14.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSWebBridgeViewController.h"
#import "WebViewJavascriptBridge.h"
#import "NJKWebViewProgress.h"
#import "AppDelegate.h"

@interface GDWSWebBridgeViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    NSDictionary *_shareDic;
    UIView *backgVIew;
    UIView *backView;
}

/**
 *  webView
 */
@property (nonatomic, strong) UIWebView *webView;

/**
 *  加载的url，由urlString生成
 */
@property (nonatomic, strong) NSURL *url;

/**
 *  加载的urlRequest,由url生成
 */
@property (nonatomic, strong) NSURLRequest *request;

/**
 *  监测加载进度
 */
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

/**
 *  显示的进度条
 */
@property (nonatomic, strong) UIProgressView *progressView;

/**
 *  连接js事件的bridge
 */
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;

/**
 *  网络状态检测
 */
@property (nonatomic, strong) AFNetworkReachabilityManager *reach;

/**
 *  js的回调block，oc向js传参数
 */
@property (nonatomic, copy) WVJBResponseCallback jsCallBack;

/**
 *  是否正在加载
 */
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation GDWSWebBridgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏下不显示内容
//    if (OS_VERSION >= 7.0) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, SA_NAVBAR_HEIGHT_WITH_STATUS_BAR, self.view.width, self.view.height - SA_NAVBAR_HEIGHT_WITH_STATUS_BAR)];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    //开始调试
    [WebViewJavascriptBridge enableLogging];
    
    // 创建进度条
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.progressTintColor = [UIColor orangeColor];
    _progressView.trackTintColor = [UIColor whiteColor];
    _progressView.frame = CGRectMake(0, SA_NAVBAR_HEIGHT_WITH_STATUS_BAR, SA_SCREEN_WIDTH, 1);
    [self.view addSubview:_progressView];
    
    // 创建进度检测
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    __weak typeof (self) weakSelf = self;
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [self.bridge setWebViewDelegate:_progressProxy];
    // WebViewJavascriptBridge关联webview
   
    [self.bridge registerHandler:@"GDWSCallHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (data == nil) {
            responseCallback(@"参数为空");
            return;
        }
        weakSelf.jsCallBack =  responseCallback;
        NSDictionary *dicData = [data isKindOfClass:[NSDictionary class]] ?(NSDictionary*)data:nil;
        [weakSelf callMethodDictionary:dicData];
    }];
    
    //    //  js调oc方法（可以通过data给oc方法传值，使用responseCallback将值再返回给js）
    //    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
    //        NSLog(@"testObjcCallback called: %@", data);
    //        responseCallback(@"Response from testObjcCallback");
    //    }];
    //
    //    // oc给js传值（通过 response接受返回值 ）
    //    [_bridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
    //        NSLog(@"objc got response! %@", responseData);
    //    }];
    //
    //    // oc调js方法（通过data可以传值，通过 response可以接受js那边的返回值
    //    [_bridge callHandler:@"hand" data:@{ @"foo":@"before ready" }];
    //
    //    // oc给js传值（无返回值）
    //    [_bridge send:@"A string sent from ObjC after Webview has loaded."];
    
    //加载urlstring
    [self loadWebView];
    
    // 启动网络状态检测
    self.reach = [AFNetworkReachabilityManager sharedManager];
    [self.reach setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if (strongSelf.isLoading) {
            if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN) {
                [strongSelf.webView loadRequest:strongSelf.request];
            }
        }
    }];
    [self.reach startMonitoring];
}

-(void)initNavButtons
{
    [super initNavButtons];
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = KNavBarLeftBtnSpace;
    UIButton* backButton = [[UIButton alloc]init];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backButton.left = 10;
    backButton.top = (SA_NAVBAR_HEIGHT - backButton.height) / 2;
    [backButton setEnlargeEdge:5];
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItems:@[flexSpacer,leftBarItem]];
}

- (void)backButtonClicked:(id)sender {
    
        if ([_webView canGoBack]) {
//            if ([self.urlString msContainsString:@"msHome"]) {
//              //  [[MSGlobalSingleton sharedInstance].mainTabBarController selectTabIndex:0];
//            }else if([self.urlString msContainsString:@"newPage"]){
//                GDWSWebBridgeViewController *webview  = [[GDWSWebBridgeViewController alloc]init];
//                NSRange range = [self.urlString rangeOfString:@"newPage"];
//                NSString * result = [self.urlString substringFromIndex:range.location];
//                webview.urlString = result;
//                [self dismissViewControllerAnimated:YES completion:nil];
//                [self.navigationController pushViewController:webview animated:YES];
//            }else{
              [_webView goBack];
//            }
        }else{
    
            [self.navigationController popViewControllerAnimated:YES];
        }
}

/**
 *  字符串转化成字典
 *
 *  @param animated <#animated description#>
 */

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return diction;
}

- (void)loadWebView
{
    if ((self.urlString||self.postURL)&& self.webView) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        if (self.postURL) {
            [request setURL:[NSURL URLWithString:self.postURL]];
            [request setHTTPMethod:@"POST"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:_postData];
        }else if(self.urlString){
            [request setHTTPMethod: @"GET"];
            [request setURL:[NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//            [request setURL:[NSURL URLWithString:self.urlString]];
        }
        //#warning test
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_webView loadRequest: request];
            
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (self.cleanCacheOnDealloc) {
        
        if (!self.url)
        {
            return;
        }
        
        //清除cookies
        NSHTTPCookie *cookie;
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookiesForURL:self.url])
        {
            [storage deleteCookie:cookie];
        }
        //清除UIWebView的缓存
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.request];
    }
}

-(void)closeView:(NSDictionary *)dic {
    //关闭页面
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)showLoading:(NSDictionary *)dic {
    [self.view showHudForLoading];
}

- (void)cancleLoading:(NSDictionary *)dic {
    [self.view hideHude];
}

- (void)loadPageFinish:(NSDictionary *)dic {
    [self dismissViewControllerAnimated:YES completion:nil];
    GDWSWebBridgeViewController *webview = [[GDWSWebBridgeViewController alloc]init];
    webview.urlString = dic[@"parameters"][@"url"];
    [self.navigationController pushViewController:webview animated:YES];
}

- (void)loadPage:(NSDictionary *)dic {
    //加载web指定的页面
    GDWSWebBridgeViewController *loadPage =[[GDWSWebBridgeViewController alloc]init];
    
    NSString *url = dic[@"parameters"][@"page"];
    //    if ([self isBlankString:url] == YES) {
    //        return;
    //    }
    loadPage.urlString = url;
    loadPage.hideTabbar = YES;
    loadPage.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loadPage animated:YES];
}

-(void)getAdId:(NSDictionary *)dic
{
    self.jsCallBack(@{@"adId":_mallAdId});
}
//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (void)callMethodDictionary:(NSDictionary *)dic {
    SEL selAction = NSSelectorFromString([NSString stringWithFormat:@"%@:",dic[@"call_method"]]);
    if ([self respondsToSelector:selAction]) {
        [self performSelector:selAction withObject:dic];
    }
}

#pragma mark - UIWebViewDelegate
/**
 *  当webview发送一个请求之前都会调用这个方法，返回yes可以加载这个请求，返回no代表禁止加载这个请求
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"web should load  %@",request);
    NSLog(@"BODY: %@",[[NSString alloc]initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] );
    
    NSString *requestString = request.URL.absoluteString;
//    if ([requestString rangeOfString:kInvestmentUrl].location == NSNotFound) {
//        self.navigationItem.leftBarButtonItem = nil;
//    }
   // return [self shouldHandleRequestUrlString:requestString];
//    return nil;

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"web view did start load");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // oc调js方法（通过data可以传值，通过 response可以接受js那边的返回值
    // [_bridge callHandler:@"test" data:@{ @"foo":@"before ready" }];
    
//        [_bridge send:@"A string sent from ObjC before Webview has loaded." responseCallback:^(id responseData) {
//            NSLog(@"objc got response! %@", responseData);
//        }];
    

    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == 0.0) {
        self.isLoading = YES;
        self.webView.alpha = 0;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        _progressView.progress = 0;
        [UIView animateWithDuration:0.25 animations:^{
            _progressView.alpha = 1.0;
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.isLoading = NO;
        self.webView.alpha = 1.0f;
        /**
         *  活得当前网页的标题
         */
        NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.navigationItem.title = title;
        [UIView animateWithDuration:0.25 delay:progress - _progressView.progress options:0 animations:^{
            _progressView.alpha = 0.0;
        } completion:nil];
        
        if ([self.delegate respondsToSelector:@selector(webView:loadFinishedWithTitle:)]) {
            [self.delegate webView:self loadFinishedWithTitle:title];
        }
        
    }
    
    [_progressView setProgress:progress animated:NO];
}


#pragma mark - Setters

- (void)setUrlString:(NSString *)urlString
{
    _urlString = nil;
    _urlString = [urlString copy];
    [self loadWebView];
}

-(void)setPostURL:(NSString *)url{
    _postURL = nil;
    _postURL = [url copy];
    [self loadWebView];
}

-(void)setMallAdId:(NSString *)mallAdId
{
    _mallAdId = mallAdId;
}

/**
 *
 *
 *  @param hideNavBar 隐藏导航条
 */
- (void)setHideNavBar:(BOOL)hideNavBar
{
    _hideNavBar = hideNavBar;
    self.navigationController.navigationBarHidden = _hideNavBar;
}

@end
