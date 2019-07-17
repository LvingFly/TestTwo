//
//  SAEmptyView.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAEmptyView;

@protocol SAEmptyViewDelegate <NSObject>

// 重新刷新
- (void)onDismissEmptyView:(SAEmptyView*)emptyView;

@end

//通用错误页面（空页面）
@interface SAEmptyView : UIView

@property (nonatomic,weak) id<SAEmptyViewDelegate> delegate;

@end
