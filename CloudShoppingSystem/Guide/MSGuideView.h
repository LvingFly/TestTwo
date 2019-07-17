//
//  MSGuideView.h
//  MinShengOK
//
//  Created by 飞光普 on 15/4/28.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSPageControl;

@protocol MSGuideViewDelegate <NSObject>
@optional
-(void)guideViewWillRemove;
-(void)guideViewDidRemove;
@end

@interface MSGuideView : UIView<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *bgScrollView;
    MSPageControl* pageControl;
    NSArray *imageList;
}

//设置表示有多少页的和当前处于第几页的小圆圈可见性
-(void)setPageControllerVisible:(BOOL)visible;

@property(nonatomic,retain)NSArray *imageList;
@property(nonatomic,assign)BOOL isDismissing;
@property(nonatomic,assign)id<MSGuideViewDelegate>delegate;
@property(nonatomic,assign)BOOL allowExit;

@end
