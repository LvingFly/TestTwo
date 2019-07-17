//
//  SFCTabBarViewController.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SATabBarViewController.h"

@interface SATabBarViewController ()

@end

@implementation SATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavButtons
{
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    flexSpacer.width = KNavBarLeftBtnSpace;
    UIButton* backButton = [[UIButton alloc]init];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
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

#pragma 横竖屏
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
