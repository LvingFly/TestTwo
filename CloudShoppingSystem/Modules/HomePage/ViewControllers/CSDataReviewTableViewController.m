//
//  CSDataReviewTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//数据查看
#import "CSDataReviewTableViewController.h"
#import "CSDataReviewHeaderView.h"
#import "CSDataWebViewController.h"

@interface CSDataReviewTableViewController ()<CSDataReviewHeaderViewDelegate>

@property (nonatomic, strong)CSDataReviewHeaderView *dataReviewHeaderView;

@end

@implementation CSDataReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"数据展示" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

- (void)initSubview {
    self.tableView.frame = CGRectMake(0, 64, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT-49);
    self.tableView.tableHeaderView = self.dataReviewHeaderView;
    self.tableView.backgroundColor = [UIColor whiteColor];
}


#pragma mark  CSDataReviewHeaderViewDelegate
-(void)webButtonClicked:(UIButton *)button {
    DebugLog(@"按钮的tag值是%ld",(long)button.tag);
    
    CSDataWebViewController *vc = [[CSDataWebViewController alloc] init];
    
    NSInteger webTag = button.tag - 1000;
    switch (webTag) {
        case 0:
            vc.webTitle = @"客流信息";
            vc.webUrl = @"http://192.168.1.68:8080/MMM/stapage/html/passengerInfo.html";
            break;
        case 1:
            vc.webTitle = @"销售状况";
            vc.webUrl = @"http://192.168.1.68:8080/MMM/stapage/html/saleStatus.html";
            break;
        case 2:
            vc.webTitle = @"会员";
            vc.webUrl = @"http://192.168.1.68:8080/MMM/stapage/html/member.html";
            break;
        case 3:
            vc.webTitle = @"店铺出租";
            vc.webUrl = @"http://192.168.1.68:8080/MMM/stapage/html/shopRent.html";
            break;
        default:
            vc.webTitle = @"费用收费状况";
            vc.webUrl = @"http://192.168.1.68:8080/MMM/stapage/html/costCollect.html";
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark  懒加载
- (CSDataReviewHeaderView *)dataReviewHeaderView {
    if (!_dataReviewHeaderView) {
        _dataReviewHeaderView = ({
            CSDataReviewHeaderView *view = [[CSDataReviewHeaderView alloc] init];
            view.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 420*SA_SCREEN_SCALE);
            view.delegate = self;
            view;
        });
    }
    return _dataReviewHeaderView;
}







@end
