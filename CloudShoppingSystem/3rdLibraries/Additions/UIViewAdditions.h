//
//  UIViewAdditions.h
//  DandelionPhone
//
//  Created by Tracy E on 12-11-30.
//  Copyright (c) 2012 China M-World Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MSPresentView.h"
@interface UIView (Additions)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

/**
 * return a screenshot of the current view.
 */
- (UIImage *)imageRepresentation;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;


//- (void)presentView:(MSPresentView *)view;


- (void)dismissView:(UIView *)view;
@end
