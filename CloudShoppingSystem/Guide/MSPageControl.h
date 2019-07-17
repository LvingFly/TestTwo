//
//  MSPageControl.h
//  MinShengOK
//
//  Created by 飞光普 on 15/7/15.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPageControl;

@protocol MSPageControlDelegate <NSObject>

-(void)onPageDotClicked:(NSInteger)dotIndex;

@end

@interface MSPageControl : UIView

-(id)initWithFrameAndPageNumber:(CGRect)frame pageNumber:(NSInteger)pageNumber;

@property(nonatomic, weak)id<MSPageControlDelegate> delegate;
@property(nonatomic)NSInteger currentPage;
@property(nonatomic)NSInteger pageNumber;

@end
