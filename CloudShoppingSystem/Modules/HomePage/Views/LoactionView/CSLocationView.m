//
//  CSLocationView.m
//  CloudShoppingSystem
//
//  Created by Living on 2017/7/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSLocationView.h"

@implementation CSLocationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    [self addSubview:self.locationView];
//    self.locationView.delegate = self;
    // 2.创建URL
    
//    NSURL *url = [NSURL URLWithString:@"http://gowins.imwork.net:8680/mmm/index.php?s=/Api/Member/getPatrolUser"];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.68:8080/MMM/stapage/html/getPatrolUser.html"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [self.locationView loadRequest:request];
    // 5.最后将webView添加到界面
    [self addSubview:self.locationView];
    [self.locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
}

- (UIWebView *)locationView {
    if (!_locationView) {
        _locationView = [[UIWebView alloc] init];
    }
    return _locationView;
}

@end
