//
//  MSGuideViewController.m
//  NewSolution
//
//  Created by chenxu on 14-5-9.
//  Copyright (c) 2014年 com.winchannel. All rights reserved.
//

#import "MSGuideViewController.h"
#import "AppDelegate.h"
#import "MSGuideView.h"

#ifndef MS_GUIDE_VIEW_CONTROLLER
#define MS_GUIDE_VIEW_CONTROLLER

#define GUIDE_IS_SHOW_MARK @"guideIsShowMark"

#endif

#pragma mark - 自定义引导视图管理器 延展(内部)
@interface MSGuideViewController ()<MSGuideViewDelegate>

@property (nonatomic, assign) BOOL isHiddenStatusBar;               //是否隐藏状态栏标示

@end

#pragma mark - 自定义引导视图管理器 延展(工具)
@interface MSGuideViewController (tools)

- (void)setStatusBarHiddenState:(BOOL)isHidden; //设置状态栏隐藏状态

@end

#pragma mark - 自定义引导视图管理器
@implementation MSGuideViewController

#pragma mark - 旋转支持接口方向回调(6.0)
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - 是否可以旋转回调(6.0)
- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - 旋转支持接口方向回调(6.0以下)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    return NO;
}

#pragma mark - 重写隐藏状态栏设定方法
- (BOOL)prefersStatusBarHidden
{
    return self.isHiddenStatusBar;
}

#pragma mark - 重写父类视图即将删除回调方法
- (void)viewWillDisappear:(BOOL)animated
{
    [self setStatusBarHiddenState:NO];
    [super viewWillDisappear:animated];
}

#pragma mark - 重写init方法
- (id)init
{
    self = [super init];
    if(self)
    {
        [self setStatusBarHiddenState:YES];
    }
    return self;
}

#pragma mark - 重写后加载视图方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //显示引导页面
    MSGuideView* guideView = [[MSGuideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    guideView.delegate = self;
    [self.view addSubview:guideView];
    
    //引导页已加载，下次启动不在启动引导页
    NSString* appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [[NSUserDefaults standardUserDefaults]setObject:appVersion forKey:KAppGuidedVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - MSGuideViewDelegate
-(void)guideViewDidRemove
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate guideFinishStart];
}

-(void)guideViewWillRemove
{
    
}

#pragma mark - ＋号方法 判定是否显示引导视图
+ (BOOL) isShowGuideView
{
    NSString *guidedVersion = [[NSUserDefaults standardUserDefaults]stringForKey:KAppGuidedVersion];
    NSString* appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if(guidedVersion == nil || ![guidedVersion isEqualToString:appVersion])
    {
        return YES;
    }

    return NO;
}

@end

@implementation MSGuideViewController (tools)

#pragma mark - 设置状态栏隐藏状态
- (void)setStatusBarHiddenState:(BOOL)isHidden
{
    NSNumber *isVCBasedStatusBarAppearanceNum = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIViewControllerBasedStatusBarAppearance"];
    if(isVCBasedStatusBarAppearanceNum.boolValue == NO)
    {
        self.isHiddenStatusBar = isHidden;
        [[UIApplication sharedApplication] setStatusBarHidden:self.isHiddenStatusBar withAnimation:NO];
    }
    else
    {
        self.isHiddenStatusBar = isHidden;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
        {
            [self prefersStatusBarHidden];
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }
        else
            [[UIApplication sharedApplication] setStatusBarHidden:self.isHiddenStatusBar withAnimation:NO];
    }
}

@end
