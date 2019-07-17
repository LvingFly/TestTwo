//
//  SARefreshViewController.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseViewController.h"
#import "SANetErrorView.h"
#import "SAEmptyView.h"

@interface SARefreshViewController : SABaseViewController <SANetErrorViewDelegate, SAEmptyViewDelegate>

@property(nonatomic, strong) SAEmptyView* emptyView;
@property(nonatomic, strong) SANetErrorView* netErrorView;

//刷新或加载更多时候的实际操作（子类实现：具体的刷新或者加载更多操作）
-(void)refresh;
-(void)loadMore;

//停止刷新或加载更多
-(void)stopRefreshLoadMore;

@end
