//
//  MSUIViewExtent.m
//  MinShengOK(V1.0.0)
//
//  Created by chenxu on 15-7-29.
//  Copyright (c) 2015年 __minshengec__. All rights reserved.
//

#import "MSUIViewExtent.h"
#import "AMTumblrHud.h"
//#import "MSCAnimationIndicator.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIView ()

@end

@implementation UIView (TTCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
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
-(void)showHudWithTitle:(NSString*)title
            description:(NSString*)description
        isShowIndicator:(BOOL)isShowIndicator
          isAutoDismiss:(BOOL)isAutoDismiss
{
    [self showHudWithTitle:title description:description
           isShowIndicator:isShowIndicator
             isAutoDismiss:isAutoDismiss
       delaySecondsForHide:1];
}
-(void)showMessageHud:(NSString*)msg
{
    [self showHudWithTitle:nil
               description:msg
           isShowIndicator:NO
             isAutoDismiss:YES];
}
-(void)showHudWithTitle:(NSString*)title
            description:(NSString*)description
        isShowIndicator:(BOOL)isShowIndicator
          isAutoDismiss:(BOOL)isAutoDismiss
    delaySecondsForHide:(NSTimeInterval)delay
{
    [self hideHude];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (isShowIndicator) {
        hud.mode = MBProgressHUDModeIndeterminate;
    }else{
        hud.mode = MBProgressHUDModeText;
    }
    //    hud.color = [UIColor colorWithRed:227.0/255 green:11.0/255 blue:33.0/255 alpha:.75];
    //    hud.yOffset = 0;
    hud.yOffset = - 70;
    hud.margin = 20;
    hud.labelFont = [UIFont systemFontOfSize:15];
    hud.labelText = title;
    hud.detailsLabelText = description;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    hud.removeFromSuperViewOnHide = YES;
    if (isAutoDismiss) {
        [hud hide:YES afterDelay:delay];
    }
}

-(void)showHudForLoading {
    [self hideHude];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"正在加载";
    [HUD show:YES];
    
//    AMTumblrHud *tumblrHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake(0,0, 55, 20)];
//    tumblrHUD.hudColor = UIColorFromRGB(0xF1F2F3);//[UIColor magentaColor];
//    [tumblrHUD showAnimated:YES];
//    [self addSubview:tumblrHUD];
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self addSubview:view];
   
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWCScreenSize.width, kWCScreenSize.height)];
//    view.backgroundColor = [UIColor whiteColor];
//    [self addSubview:view];
//    MSCAnimationIndicator *indicator = [[MSCAnimationIndicator alloc]initWithFrame:CGRectMake(self.width/2 - 75/2, self.height/2 - 64/2, 75, 34 + 30)];
//    
//    [indicator setLoadText:@"努力加载中..."];
//    [indicator startAnimation];
//    [view addSubview:indicator];
//    hud.margin = 0;
//    hud.color = [UIColor clearColor];
//    hud.customView = view;
//    hud.removeFromSuperViewOnHide = YES;
    
}

-(void)showHudForLoading:(NSString *)text {
    [self hideHude];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    //    hud.color = [UIColor colorWithRed:227.0/255 green:11.0/255 blue:33.0/255 alpha:.75];
    
    AMTumblrHud *tumblrHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake(0,0, 55, 20)];
    tumblrHUD.hudColor = UIColorFromRGB(0xF1F2F3);//[UIColor magentaColor];
    [tumblrHUD showAnimated:YES];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
//    MSCAnimationIndicator *indicator = [[MSCAnimationIndicator alloc]initWithFrame:CGRectMake(self.width/2 - 75/2, self.height/2 - 64/2, 75, 34 + 30)];
//    [indicator setLoadText:text];
//    [indicator startAnimation];
//    
//    hud.color = [UIColor clearColor];
//    hud.customView = indicator;
//    hud.removeFromSuperViewOnHide = YES;
}

-(void)showMessageHud:(NSString*)msg delaySecondsForHide:(NSTimeInterval)delay
{
    [self showHudWithTitle:msg
               description:nil
           isShowIndicator:NO
             isAutoDismiss:YES];
}
-(void)hideHude
{
    [MBProgressHUD hideAllHUDsForView:self animated:NO];
}

- (NSArray *)allHUDsForView:(UIView *)view {
    return [MBProgressHUD allHUDsForView:view];
}

@end
