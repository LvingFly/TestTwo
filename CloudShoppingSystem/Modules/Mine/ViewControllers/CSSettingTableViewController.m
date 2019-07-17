//
//  CSSettingTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSettingTableViewController.h"
#import "PMSettingTableViewCell.h"
#import "AppDelegate.h"

@interface CSSettingTableViewController ()

@property(nonatomic, strong)NSArray     *titleArray;

@end

@implementation CSSettingTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = [NSArray arrayWithObjects:@"清除缓存",@"关于",@"退出登录", nil];
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 10 * SA_SCREEN_SCALE, 0, 10 * SA_SCREEN_SCALE);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"设置" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0://清理缓存
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认清除缓存？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SDImageCache sharedImageCache] clearDisk];
//                [self.tableView reloadData];
            }];
            [alertController addAction:cancelAction];
            
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case 1://关于
        {
            [self showError:@"内容正在制定中"];
            break;
        }
        case 2://退出登录
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SAUserInforManager shareManager]logOut];
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate showLoginViewController];
//                [[SAUserInforManager shareManager] removeObserver:self forKeyPath:@"isAuthValid"];
//                [[SAUserInforManager shareManager] removeObserver:self forKeyPath:@"error"];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PMSettingTableViewCell  cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[PMSettingTableViewCell cellIdentifier]];
    if (cell == nil) {
        cell = [[PMSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PMSettingTableViewCell cellIdentifier]];
    }
    
    if (indexPath.row < self.titleArray.count) {
        NSString *string = [self.titleArray objectAtIndex:indexPath.row];
        [cell setTitleString:string];
    }
    
    return cell;
}



#pragma mark  弹框提示
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
@end
