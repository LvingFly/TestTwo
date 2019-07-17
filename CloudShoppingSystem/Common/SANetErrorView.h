//
//  SAErrorImageView.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/20.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SANetErrorView;

@protocol SANetErrorViewDelegate <NSObject>

// 重新刷新
- (void)onDismissNetErrorView:(SANetErrorView*)errorView;

@end

//通用错误页面（网络错误页面）
@interface SANetErrorView : UIView

@property (nonatomic,weak) id<SANetErrorViewDelegate> delegate;

@end
