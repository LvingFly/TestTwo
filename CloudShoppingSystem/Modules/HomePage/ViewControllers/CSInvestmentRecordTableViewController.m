//
//  CSInvestmentRecordTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//招商记录
#import "CSInvestmentRecordTableViewController.h"
#import "CSInvestRecordTableViewCell.h"
#import "CSInvestmentRecordTableViewController.h"
#import "CSInvestmentDetailTableViewController.h"
#import "CSMerchantsModel.h"

@interface CSInvestmentRecordTableViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField         *searchTextField;
@property(nonatomic, strong)NSMutableArray  *dataArray;

@end

@implementation CSInvestmentRecordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self initData];
    [self.tableView registerClass:[CSInvestRecordTableViewCell class] forCellReuseIdentifier:[CSInvestRecordTableViewCell cellIdentifier]];
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self initHeaderView];
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData {
    [self getNegotiationByCodeAndAccount];
}

- (void)getNegotiationByCodeAndAccount {
    __weak typeof (self) weakSelf = self;
    
    [weakSelf.view showMessageHud:@"加载中"];
    NSString *misToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_MisToken];
    SAHttpNetworkManager *netWorkManager = [SAHttpNetworkManager defaultManager];
    [netWorkManager getNegotiationByCodeAndAccountWithToken:misToken Account:@"superadmin" Code:@"" CurrentPage:@"1" PageSize:@"10" callBack:^(id resp, NSError *error) {
        if (!error){
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]]?(NSDictionary*)resp:nil;
            if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 0) {
                NSArray *dataArray = [dicData validValueForKey:@"rows"];
                DebugLog(@"%@",dataArray);
                
                for (NSDictionary *dic in dataArray) {
                    CSMerchantsModel *model = [[CSMerchantsModel alloc] initWithDictionary:dic];
                    DebugLog(@"%@",model);
                    [self.dataArray addObject:model];
                }
                
                [self.tableView reloadData];
            
            }else{
                if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 1) {
                    NSString *errorMessage = @"登录失败";
                    if ([dicData validValueForKey:@"errmsg"]) {
                        errorMessage = [dicData validValueForKey:@"errmsg"];
                    }
                }
            }
        }
        else{
            
            
            NSString *errorMessage = @"登录失败，请重试！";
            if ([error code] == KNoNetWorkErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            
            
        }
    }];
    
    
}




-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"招商记录" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *addButton = [[UIButton alloc]init];
    addButton.backgroundColor = [UIColor clearColor];
    [addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addButton sizeToFit];
    addButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    addButton.top = (SA_SCREEN_HEIGHT - addButton.height)/2;
    [addButton addTarget:self action:@selector(addButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
//    [self.navigationItem setRightBarButtonItem:rightBarItem];
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
//    self.tableView.tableHeaderView = headerView;
}

#pragma --mark button clicked
-(void)addButtonClicked:(UIButton *)button
{
    
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSInvestmentDetailTableViewController *controller = [[CSInvestmentDetailTableViewController alloc]init];
    controller.detailModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[CSInvestRecordTableViewCell cellIdentifier] configuration:^(id cell) {
        
    }];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSInvestRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSInvestRecordTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSInvestRecordTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSInvestRecordTableViewCell cellIdentifier]];
    }
    
    if (self.dataArray.count > 0) {
        CSMerchantsModel *model = self.dataArray[indexPath.row];
        [cell.backLogDateLabel setText:model.createTime];
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
