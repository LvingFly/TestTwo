//
//  CSEventFunctionFooterView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/28.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CSEventFunctionFooterViewDelegate <NSObject>

-(void)action_footViewBtn;

@end

@interface CSEventFunctionFooterView : UIView
@property (nonatomic, weak)id<CSEventFunctionFooterViewDelegate>delegate;


@end
