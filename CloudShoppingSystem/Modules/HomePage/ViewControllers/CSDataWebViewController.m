//
//  CSDataWebViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/6.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSDataWebViewController.h"

@interface CSDataWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIWebView *transitionWebView;


@end

@implementation CSDataWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 64;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, width, height)];
    webView.delegate = self;
    // 2.创建URL
    NSURL *url = [NSURL URLWithString:self.webUrl];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
    // 5.最后将webView添加到界面
    [self.view addSubview:webView];
    self.webView = webView;
    
    
    NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refresh_image" ofType:@"gif"]];
    UIWebView *tempWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    [tempWebView setScalesPageToFit: YES];
    [tempWebView setBackgroundColor: [UIColor clearColor]];
    [tempWebView setOpaque: 0];
    [self.view addSubview:tempWebView];
    [tempWebView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
    [tempWebView setUserInteractionEnabled:NO];
    self.transitionWebView = tempWebView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavButtons{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:self.webTitle backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {


}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.transitionWebView removeFromSuperview];
    
}

@end
