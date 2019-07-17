//
//  SABaseViewController.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseViewController.h"
#import "AppDelegate.h"

@interface SABaseViewController () <UIAlertViewDelegate>

@end

@implementation SABaseViewController

-(id)init
{
    self = [super init];
    
    if (self) {
        self.type = EBaseViewController;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KDefaultBackgroundColor;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavButtons];
}

- (void)dealloc
{
    [self removeNotificationAndKVO];
}

-(void)registNotificationAndKVO
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needReloginApp) name:KBAD_TOKEN_NOTIFICATION object:nil];
}

-(void)removeNotificationAndKVO
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initNavButtons
{
   UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = KNavBarLeftBtnSpace;
    UIButton* backButton = [[UIButton alloc]init];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backButton.left = 10;
    backButton.top = (SA_NAVBAR_HEIGHT - backButton.height) / 2;
    [backButton setEnlargeEdge:5];
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItems:@[flexSpacer,leftBarItem]];
 }

-(void)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)needReloginApp
{
//    if ([SAUserInforManager shareManager].relogining == NO) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"重复登录" message:@"您的帐号已在其它地方登录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        
//        [alert show];
//        
//        [SAUserInforManager shareManager].relogining = YES;
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    if ([SALoginView sharedView].isShowing == NO) {
//        [SALoginView showWithAnimation];
//        
//        [[SAUserInforManager shareManager] logOut];
//        
//        AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate moveTabbarToIndex:0];
//    }
}

@end
