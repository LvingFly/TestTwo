//
//  MSUIResponderExtention.m
//  WinCRM
//
//  Created by chenxu on 13-7-12.
//  Copyright (c) 2013年 WinChannel. All rights reserved.
//
#define kMSRadiusOverlayHeight 22

#import "MSUIResponderExtention.h"

@implementation UIResponder(Extention)

- (void)performBlockOnMainThread:(void(^)(void))block afterDelay:(NSTimeInterval)timeInterval
{
    double delayInSeconds = timeInterval;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (void)addRadiusOverlay:(UIView*)view
{
    UIImageView* topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        view.frame.size.width,
                                                                        kMSRadiusOverlayHeight)];
    topImg.image = [UIImage imageNamed:@"mask_top"];
    [view addSubview:topImg];
    UIImageView* bottomImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                           view.frame.size.height - kMSRadiusOverlayHeight,
                                                                           view.frame.size.width,
                                                                           kMSRadiusOverlayHeight)];
    bottomImg.image = [UIImage imageNamed:@"mask_bottom"];
    [view addSubview:bottomImg];
}
@end

@implementation MSCExternButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
