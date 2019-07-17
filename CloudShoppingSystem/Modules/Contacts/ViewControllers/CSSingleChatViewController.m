//
//  CSSingleChatViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/7.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSingleChatViewController.h"

@interface CSSingleChatViewController ()

@end

@implementation CSSingleChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    
    UILabel *titleLabel = [SAControlFactory createLabel:_titleLabel backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(20) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
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

- (void)backButtonClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
