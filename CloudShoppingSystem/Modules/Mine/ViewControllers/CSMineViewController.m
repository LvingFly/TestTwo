//
//  CSMineViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMineViewController.h"
#import "CSMineTableHeaderView.h"
#import "CSMineTableViewCell.h"
#import "CSMessageTableViewController.h"
#import "CSAccountAndSecurityViewController.h"
#import "CSChangeThemeViewController.h"
#import "CSHelpViewController.h"
#import "CSSettingTableViewController.h"
#import "CSPersonalInfoViewController.h"

@interface CSMineViewController ()<CSMineTableHeaderViewDelegate>

@property(nonatomic, strong)CSMineTableHeaderView   *tableHeaderView;
@property(nonatomic, strong)NSArray                 *titleArray;
@property(nonatomic, strong)NSArray                 *imageArray;
@property(nonatomic, strong)NSString                 *uid;
@end

@implementation CSMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    self.uid = userID;
//    self.titleArray = @[@"销售部",@"账号与安全",@"主体换肤",@"帮助与反馈",@"设置"];
//        self.titleArray = @[@"销售部",@"主体换肤",@"帮助与反馈",@"设置"];
    self.titleArray = @[@"销售部",@"帮助与反馈",@"设置"];
//    self.imageArray = @[@"department",@"security",@"changeTheme",@"help",@"setting"];
    self.imageArray = @[@"department",@"help",@"setting"];

    self.tableHeaderView.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 1 * SA_SCREEN_SCALE);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10 * SA_SCREEN_SCALE, 0, 10 * SA_SCREEN_SCALE);
    float height = [self.tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.tableHeaderView.height = height;
    self.tableView.tableHeaderView = self.tableHeaderView;
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)initNavButtons
{
    UILabel *titleLabel = [SAControlFactory createLabel:@"个人中心" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *messageButton = [[UIButton alloc]init];
    messageButton.backgroundColor = [UIColor clearColor];
    [messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [messageButton sizeToFit];
    messageButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    messageButton.top = (SA_SCREEN_HEIGHT - messageButton.height)/2;
    [messageButton addTarget:self action:@selector(messageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:messageButton];
//    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

#pragma --mark CSMineTableHeaderViewDelegate
//点击头像进入个人信息
-(void)headerImageClicked
{
    
    CSPersonalInfoViewController *controller = [[CSPersonalInfoViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)checkInClicked:(UIButton *)sender {
    [self.view showMessageHud:@"加载中"];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view showMessageHud:@"签到成功"];
    });
    return;
 
    
}


#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0 :
        {
            
        }
            break;
//        case 0:
//        {
//            CSAccountAndSecurityViewController *controller = [[CSAccountAndSecurityViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
//        }
//            break;
        case 1:
        {
//            CSChangeThemeViewController *controller = [[CSChangeThemeViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            CSHelpViewController *controller = [[CSHelpViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:
        {
//            CSHelpViewController *controller = [[CSHelpViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            
            CSSettingTableViewController *controller = [[CSSettingTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:
        {
//            CSSettingTableViewController *controller = [[CSSettingTableViewController alloc]init];
//            controller.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CSMineTableViewCell cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSMineTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSMineTableViewCell cellIdentifier]];
    }
    if (indexPath.row < self.titleArray.count) {
        NSString *title = [self.titleArray objectAtIndex:indexPath.row];
        NSString *imageString = [self.imageArray objectAtIndex:indexPath.row];
        
        [cell setTitle:title imageString:imageString];
    }
    
    if (indexPath.row == 0) {
        [cell setSubTitle:@"销售专员"];
    }
    return cell;
}

#pragma --mark button clicked
-(void)messageButtonClicked:(UIButton *)button
{
    CSMessageTableViewController *controller = [[CSMessageTableViewController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma --mark 懒加载
-(CSMineTableHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = ({
            CSMineTableHeaderView *view = [[CSMineTableHeaderView alloc]initWithFrame:CGRectZero];
            view.delegate = self;
            view;
        });
    }
    return _tableHeaderView;
}

@end
