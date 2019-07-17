//
//  UIApplication+UI7.m
//  SinaWeather
//
//  Created by iBcker on 13-11-21.
//
//

#import "UIApplication+UI7.h"
#import <objc/runtime.h>

@implementation UIApplication (UI7)


+ (void)inject
{
    Method originMethod=class_getInstanceMethod(self, @selector(setStatusBarStyle:));
    Method newMethod=class_getInstanceMethod(self, @selector(__setStatusBarStyle:));
    
    method_exchangeImplementations(originMethod, newMethod);
    
    originMethod=class_getInstanceMethod(self, @selector(setStatusBarStyle:animated:));
    newMethod=class_getInstanceMethod(self, @selector(__setStatusBarStyle:animated:));
    
    method_exchangeImplementations(originMethod, newMethod);
}

- (void)__setStatusBarStyle:(UIStatusBarStyle)style
{
    [self __setStatusBarStyle:style];
    if (style==UIStatusBarStyleBlackTranslucent||style==UIStatusBarStyleLightContent) {
        [self hiddenStatusBarBackgroung];
    }else if(style==UIStatusBarStyleBlackOpaque){
        [self showStatusBarBackground];
    }
}

-(void)__setStatusBarStyle:(UIStatusBarStyle)style animated:(BOOL)animated
{
    [self __setStatusBarStyle:style animated:animated];

    if (style==UIStatusBarStyleBlackTranslucent) {
        if (animated) {
            [self performSelector:@selector(hiddenStatusBarBackgroung) withObject:self afterDelay:0.6];
        }else{
            [self hiddenStatusBarBackgroung];
        }
    }else if(style==UIStatusBarStyleBlackOpaque){
        if (animated) {
            [self performSelector:@selector(showStatusBarBackground) withObject:self afterDelay:0.6];
        }else{
            [self showStatusBarBackground];
        }
    }
}

#pragma mark --- ios 7 ui ---

- (void)attch
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
#ifdef __IPHONE_7_0
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
#endif
    [UIApplication inject];
    
//    if (MC_OS_VERSION>=5) {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//        [[UINavigationBar appearance] setTitleTextAttributes: @{
//                                                                UITextAttributeTextColor: [UIColor whiteColor],
//                                                                UITextAttributeFont: [UIFont boldSystemFontOfSize: 20.0f]}];
//        
//    }
//    
//    if (MC_OS_VERSION>=7) {
//        [[UINavigationBar appearance] setBarTintColor:[UIColor darkGrayColor]];
//    }
    [self hiddenStatusBarBackgroung];
}

- (void)hiddenStatusBarBackgroung
{
    [self hiddenStatusBarBackground:YES];
}


- (void)showStatusBarBackground
{
    [self hiddenStatusBarBackground:NO];
}

- (void)hiddenStatusBarBackground:(BOOL)hidden
{
    BOOL isStatusBarHidden=[[UIApplication sharedApplication] isStatusBarHidden];
    if (isStatusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    UIView *statusbar=[[UIApplication sharedApplication] valueForKey:@"_statusBar"];
    UIView *bgView = nil;
    NSArray *vs=[statusbar subviews];
    for (UIView *v in vs) {
        if ([v isKindOfClass:NSClassFromString(@"UIStatusBarBackgroundView")]) {
            bgView=v;
            if (OS_VERSION>=7) {
                if([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleBlackOpaque){
                    v.backgroundColor=[UIColor blackColor];
                }else{
                    v.backgroundColor=[UIColor clearColor];
                }
            }
            break;
        }
    }
    if (hidden) {
        [bgView setHidden:YES];
    }else{
        [bgView setHidden:NO];
    }
    if (isStatusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
}


@end
