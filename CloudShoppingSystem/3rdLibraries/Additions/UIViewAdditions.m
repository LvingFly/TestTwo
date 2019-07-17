//
//  UIViewAdditionsm
//  DandelionPhone
//
//  Created by Tracy E on 12-11-30.
//  Copyright (c) 2012 China M-World Co.,Ltd. All rights reserved.
//

#import "UIViewAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Additions)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)x {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)y {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage *)imageRepresentation{
    UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

//- (void)presentView:(MSPresentView *)view
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardDidShowNotification object:nil userInfo:nil];
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = .5;
//    animation.removedOnCompletion = YES;
//    animation.fillMode = kCAFillModeForwards;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
//    [view.contentView.layer addAnimation:animation forKey:nil];
//    [[[[[UIApplication sharedApplication] keyWindow] rootViewController] view] addSubview:view];
//}

- (void)dismissView:(UIView *)view
{
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardDidHideNotification object:nil userInfo:nil];
    [view removeFromSuperview];
}

@end
