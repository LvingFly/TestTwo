//
//  MSUIViewExtent.h
//  MinShengOK(V1.0.0)
//
//  Created by chenxu on 15-7-29.
//  Copyright (c) 2015年 __minshengec__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UIView (TTCategory)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

- (void)showMessageHud:(NSString *)msg;

- (void)showHudWithTitle:(NSString *)title
             description:(NSString *)description
         isShowIndicator:(BOOL)isShowIndicator
           isAutoDismiss:(BOOL)isAutoDismiss
     delaySecondsForHide:(NSTimeInterval)delay;

-(void)showHudWithTitle:(NSString*)title
            description:(NSString*)description
        isShowIndicator:(BOOL)isShowIndicator
          isAutoDismiss:(BOOL)isAutoDismiss;

- (void)showHudForLoading;

-(void)showHudForLoading:(NSString *)text;


- (void)showMessageHud:(NSString *)msg delaySecondsForHide:(NSTimeInterval)delay;

- (void)hideHude;

- (NSArray *)allHUDsForView:(UIView *)view;
@end
