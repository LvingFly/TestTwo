//
//  AppDelegate.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/2.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "AppDelegate.h"
#import "SNNavigationController.h"
#import "SATabBarViewController.h"
#import "MSGuideViewController.h"
#import "CSLoginViewController.h"
#import "CSMineViewController.h"
#import "CSEventViewController.h"
#import "CSHomePageViewController.h"
#import "CSChatListViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) CSLoginViewController *loginViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [[RCIM sharedRCIM] initWithAppKey:KRongCloudIMKey];
    
    
    
    self.loginViewController = [[CSLoginViewController alloc]init];
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [[SAUserInforManager shareManager] logOut];
     _tabbarController = [self addTabbarViewController];
    [self doFinishLaunching];
    

    [_window makeKeyAndVisible];

        
    return YES;
}

- (void)doFinishLaunching
{
//    if ([MSGuideViewController isShowGuideView] == YES) {
//        [_window setRootViewController:[[MSGuideViewController alloc]init]];
//    } else {
        //
        //        SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:[[GDWSHomePageViewController alloc]init]];
        //        [nav setNavBarBgWithColor:[UIColor clearColor]];
        //        [_window setRootViewController:nav];
//    }
    
    
    if ([SAUserInforManager shareManager].isAuthValid == YES)
    {
            [_window setRootViewController:_tabbarController];
    }else
    {
//        [[SAUserInforManager shareManager] showLoginViewController];
        [self showLoginViewController];
        
    }


}

-(void)showLoginViewController
{
    CSLoginViewController *loginViewConroller = [[CSLoginViewController alloc]init];
    [_window setRootViewController:loginViewConroller];
}


- (void)guideFinishStart
{
    [[CSLoginViewController shareLoginController] showLoginViewController];
    // [_window setRootViewController:self.loginViewController];
}

-(void)setBadegePassNumIsFresh {
    
    
    [_window setRootViewController:_tabbarController];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//跳转到指定index，并pop所有的导航栈
-(void)moveTabbarToIndex:(NSInteger)index{
    //    for (SNNavigationController *navCv in _tabbarController.viewControllers) {
    //        for (UIViewController* viewController in navCv.viewControllers) {
    //            if ([viewController isKindOfClass:[ESAllGoodsVC class]] || [viewController isKindOfClass:[FTHomePageViewController class]] || [viewController isKindOfClass:[FTFindViewController class]] || [viewController isKindOfClass:[FTShopCartViewController class]] || [viewController isKindOfClass:[FTMineViewController class]] ) {
    //                continue;
    //            }
    //            else {
    //                [viewController.navigationController popViewControllerAnimated:NO];
    //            }
    //        }
    //    }
    //
    //    for (SNNavigationController *navCv in _tabbarController.viewControllers) {
    //        [navCv popToRootViewControllerAnimated:YES];
    //    }
    //
    //    //耗时操作放到子线程操作
    //    [NSThread detachNewThreadSelector:@selector(goToFirstIndex:) toTarget:self withObject:@(index)];
    
}

-(void)goToFirstIndex:(NSString*)index
{
    
    _tabbarController.selectedIndex = index.integerValue;
    [_tabbar moveToTabbarIndex:index.integerValue];
    
}
- (UITabBarController *)addTabbarViewController
{
    CSHomePageViewController *homePageVC = [[CSHomePageViewController alloc] init];
    SNNavigationController *navHomePage = [[SNNavigationController alloc]initWithRootViewController:homePageVC];
    [navHomePage setNavBarBgWithColor:KNavBarColor];

//    CSChatListViewController *contactsVC = [[CSChatListViewController alloc] init];
//    SNNavigationController *navContacts = [[SNNavigationController alloc]initWithRootViewController:contactsVC];
//    [navContacts setNavBarBgWithColor:KNavBarColor];

    CSEventViewController *eventVC = [[CSEventViewController alloc] init];
    SNNavigationController *navEvent = [[SNNavigationController alloc]initWithRootViewController:eventVC];
    [navEvent setNavBarBgWithColor:KNavBarColor];

    CSMineViewController *mineVC = [[CSMineViewController alloc] init];
    SNNavigationController *navMine = [[SNNavigationController alloc]initWithRootViewController:mineVC];
    [navMine setNavBarBgWithColor:KNavBarColor];

    NSArray* tabbarArray = [NSArray arrayWithObjects:navHomePage,navEvent,navMine, nil ];

    _tabbarController = [[SATabBarViewController alloc] init];
    [_tabbarController.tabBar removeAllSubviews];
    _tabbarController.viewControllers = tabbarArray;

    _tabbar = [[SAAnimateTabbarView alloc] initWithFrame:_tabbarController.tabBar.frame];
    [_tabbarController.tabBar addSubview:_tabbar];

    return _tabbarController;
}

- (void)hidesTabBar:(BOOL)hidden{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for (UIView *view in _tabbarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
                
            }else{
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height - 49, view.frame.size.width, view.frame.size.height)];
                
            }
        }else{
            if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
                if (hidden) {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
                    
                }else{
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 49 )];
                    
                }
            }
        }
    }
    [UIView commitAnimations];
}

-(void)bringCustomTabbarToTop
{
    
    
    [_tabbarController.tabBar bringSubviewToFront:_tabbar];
}

@end
