//
//  AppDelegate.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/2.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAAnimateTabbarView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) UITabBarController *tabbarController;

@property (strong, nonatomic, readonly) SAAnimateTabbarView *tabbar;


//移动选中Tab栏
-(void)moveTabbarToIndex:(NSInteger)index;
//隐藏Tabbar
-(void)hidesTabBar:(BOOL)hidden;
//push层级过深后，自定义的tabbar不会显示在顶层，此函数确保自定义的tabbar显示在顶层
-(void)bringCustomTabbarToTop;

- (void)guideFinishStart;

//设置组合包数量badege, fresh 代表是否刷新自由组合包VC
-(void)setBadegePassNumIsFresh;

-(void)showLoginViewController;

@end

