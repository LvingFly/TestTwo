//
//  CSBLDetailSegmentView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCSBLDetailSegmentViewDelegate <NSObject>

- (void)didSelectButtonAtIndex:(NSInteger)index;   //得到点击button的index

@end

@interface CSBLDetailSegmentView : UIView

@property(nonatomic, weak) id<CCSBLDetailSegmentViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame AndItemsArr:(NSArray*)itemArr; //此法传入要生成的按钮title数组  是否需要竖直分割线以及竖直分割线的高度.
-(void)changeButtonTitleAtIndex:(NSInteger)index andTitle:(NSString*)title;

@end




