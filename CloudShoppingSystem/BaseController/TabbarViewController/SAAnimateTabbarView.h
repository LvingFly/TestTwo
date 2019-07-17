//
//  SAAnimateTabbarView.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SAAnimateTabbarView : UIView

@property(nonatomic,strong, readonly) UIButton *thirdBtn;

//移动tabbar（1-4）
-(void)moveToTabbarIndex:(NSInteger)index;
@end
