//
//  MSUIResponderExtention.h
//  WinCRM
//
//  Created by chenxu on 13-7-12.
//  Copyright (c) 2013年 WinChannel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder(Extention)

- (void)performBlockOnMainThread:(void(^)(void))block afterDelay:(NSTimeInterval)timeInterval;
- (void)addRadiusOverlay:(UIView*)view;
@end

@interface MSCExternButton : UIButton

@end