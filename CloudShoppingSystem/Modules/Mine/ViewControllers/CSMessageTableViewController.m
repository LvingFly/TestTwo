//
//  CSMessageTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMessageTableViewController.h"
#import "CSMessageTableViewCell.h"
#import "CSMessageDetailViewController.h"

@interface CSMessageTableViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField         *searchTextField;

@end

@implementation CSMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initHeaderView];
    
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"动态消息" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

//加载tableview header
-(void)initHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 64 * SA_SCREEN_SCALE)];
    headerView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.searchTextField];
    self.searchTextField.width = 244 * SA_SCREEN_SCALE;
    self.searchTextField.centerX = headerView.centerX;
    self.searchTextField.top = 13 * SA_SCREEN_SCALE;
    self.searchTextField.height = 30 * SA_SCREEN_SCALE;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, headerView.height - 1 * SA_SCREEN_SCALE, SA_SCREEN_WIDTH, 1 * SA_SCREEN_SCALE)];
    lineView.backgroundColor = SA_Color_HexString(0xf2f2f2, 1);
    [headerView addSubview:lineView];
    self.tableView.tableHeaderView = headerView;
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSMessageDetailViewController *controller = [[CSMessageDetailViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CSMessageTableViewCell cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSMessageTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSMessageTableViewCell cellIdentifier]];
    }
    return cell;
}

#pragma --mark 懒加载
-(UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(14)];
            [textField setTextColor:[UIColor blackColor]];
            textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeySearch;
            textField.layer.cornerRadius = 15 * SA_SCREEN_SCALE;
            textField.layer.borderColor = SA_Color_HexString(0xcccccc, 1).CGColor;
            textField.layer.borderWidth = 1 * SA_SCREEN_SCALE;
            
            textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20 * SA_SCREEN_SCALE, 0)];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_01"]];
            [imageView sizeToFit];
            imageView.centerY = textField.leftView.centerY;
            imageView.left = 10 * SA_SCREEN_SCALE;
            [textField.leftView addSubview:imageView];
            textField.leftViewMode = UITextFieldViewModeAlways;
            textField;
        });
    }
    return _searchTextField;
}

@end
