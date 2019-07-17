//
//  CSHomePageViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//主页
#import "CSHomePageViewController.h"
#import "CSBannerTableViewCell.h"
#import "CSMultifunctionTableViewCell.h"
#import "CSSingleFunctionTableViewCell.h"
#import "CSBackLogViewController.h"
#import "CSDataReviewTableViewController.h"
#import "CSInvestmentRecordTableViewController.h"
#import "CSMonitorReviewTableViewController.h"
#import "CSPollingReviewTableViewController.h"
#import "AESCrypt.h"

@interface CSHomePageViewController ()<CSMultifunctionTableViewCellDelegate>

@property(nonatomic, strong)NSArray  *functionTitleArray;
@property(nonatomic, strong)NSArray  *bannerArray;

@end

@implementation CSHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //aes 加密解密
//    NSString *cc = [AESCrypt encrypt:@"wo卧槽=*-%" password:@"625202f9149e061d"];
//    NSString *dec = [AESCrypt decrypt:cc password:@"625202f9149e061d"];
//    NSLog(@"aes解密    %@xxxx",cc);
    self.functionTitleArray = @[@"监控查看",@"巡检查看"];
    self.bannerArray = @[[UIImage imageNamed:@"banner_01.jpg"],[UIImage imageNamed:@"banner_02.jpg"],[UIImage imageNamed:@"banner_03.jpg"],[UIImage imageNamed:@"banner_04.jpg"],[UIImage imageNamed:@"banner_05.jpg"]];
    [self.tableView registerClass:[CSMultifunctionTableViewCell class] forCellReuseIdentifier:[CSMultifunctionTableViewCell cellIdentifier]];
    [self.tableView registerClass:[CSSingleFunctionTableViewCell class] forCellReuseIdentifier:[CSSingleFunctionTableViewCell cellIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)initNavButtons
{
    UILabel *titleLabel = [SAControlFactory createLabel:@"首页" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

#pragma --mark CSMultifunctionTableViewCellDelegate
-(void)selectFunctionAtIndex:(NSInteger)index
{
    switch (index) {
        case 0://待办事项
        {
            CSBackLogViewController *controller = [[CSBackLogViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1://数据查看
        {
            CSDataReviewTableViewController *controller = [[CSDataReviewTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2://招商记录
        {
            CSInvestmentRecordTableViewController *controller = [[CSInvestmentRecordTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 2:
        {
            CSMonitorReviewTableViewController *controller = [[CSMonitorReviewTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:
        {
            CSPollingReviewTableViewController *controller = [[CSPollingReviewTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return [CSBannerTableViewCell cellHeight];
            break;
        case 1:
            return [tableView fd_heightForCellWithIdentifier:[CSMultifunctionTableViewCell cellIdentifier] configuration:^(id cell) {
            }];
            break;
        case 2:
        case 3:
            return [tableView fd_heightForCellWithIdentifier:[CSSingleFunctionTableViewCell cellIdentifier] configuration:^(id cell) {
            }];
            break;
        default:
            break;
    }
    return 0;
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            CSBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBannerTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSBannerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBannerTableViewCell cellIdentifier]];
            }
            [cell setBannerListArray:self.bannerArray]; 
            return cell;
        }
            break;
        case 1:
        {
            CSMultifunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSMultifunctionTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSMultifunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSMultifunctionTableViewCell cellIdentifier]];
            }
            cell.delegate = self;
            return cell;
        }
            break;
        case 2:
        case 3:
        {
            CSSingleFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSSingleFunctionTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSSingleFunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSSingleFunctionTableViewCell cellIdentifier]];
            }
            NSInteger index = indexPath.row - 2;
            if (index < _functionTitleArray.count) {
                NSString *title = [_functionTitleArray objectAtIndex:index];
                [cell setTitle:title];
            }
            return cell;
        }
        default:
            break;
    }
    
    return nil;
}

@end
