//
//  CSDataReviewHeaderView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/6.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSDataReviewHeaderViewDelegate <NSObject>

-(void)webButtonClicked:(UIButton *)button;

@end

@interface CSDataReviewHeaderView : UIView

@property(nonatomic, weak)id<CSDataReviewHeaderViewDelegate> delegate;


@end
