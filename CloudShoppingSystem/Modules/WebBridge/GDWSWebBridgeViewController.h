//
//  GDWSWebBridgeViewController.h
//  Mall_GDWS
//
//  Created by dengyuchi on 16/7/14.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "SABaseViewController.h"

@class GDWSWebBridgeViewController;

@protocol GDWSWebviewJsDelegate <NSObject>
- (void)callMethodDictionary:(NSDictionary *)dic;

// 加载完后返回webView的title
- (void)webView:(GDWSWebBridgeViewController*)webView loadFinishedWithTitle:(NSString*)title;
@end

/**
 *  通用加载web视图
 */
@interface GDWSWebBridgeViewController : SABaseViewController

/**
 *  webView
 */
@property (nonatomic, strong, readonly) UIWebView *webView;

/**
 *  加载的weburl
 */
@property (nonatomic, copy) NSString *urlString;

/**
 *  是否在dealloc中清除webview的缓存，默认是NO
 */
@property (nonatomic, assign) BOOL cleanCacheOnDealloc;

/**
 *  是否隐藏导航栏，默认是NO
 */
@property (nonatomic, assign) BOOL hideNavBar;

//mall adId
@property (nonatomic, strong)NSString *mallAdId;

//post模式加载
@property (nonatomic,copy)NSString *postURL;
@property (nonatomic)NSData *postData;
@property (nonatomic)BOOL hideTabbar;
@property (nonatomic,weak) id<GDWSWebviewJsDelegate>delegate;

@property (nonatomic, copy) void (^relaodBlock)();

@end
