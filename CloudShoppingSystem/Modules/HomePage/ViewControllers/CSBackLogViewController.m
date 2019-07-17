//
//  CSBackLogViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//待办事项
#import "CSBackLogViewController.h"
#import "CSBackLogTableViewCell.h"
#import "CSBackLogDetailViewController.h"
#import "BackLogModel.h"
#import "CSBackLogDetailBaseModel.h"
#import "CSBackLogDetailMedModel.h"
#import "CSBackLogDetailLastModel.h"
#import "AppDelegate.h"
#import "CSEventManageModel.h"


@interface CSBackLogViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField         *searchTextField;
@property(nonatomic, strong)NSMutableArray              *untreatedArray;


@end

@implementation CSBackLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.untreatedArray = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[CSBackLogTableViewCell class] forCellReuseIdentifier:[CSBackLogTableViewCell cellIdentifier]];
    self.tableView.frame = CGRectMake(0, 64, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT-64);
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //    [self initHeaderView];
    
    
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initData];

}


- (void)initData {
    
    [self getUntreatedEvents];
    [self getMyManageUsers];
    [self getManages];
}




- (void)getUntreatedEvents {
    __weak typeof (self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *netWorkManager = [SAHttpNetworkManager defaultManager];
    [netWorkManager getUntreatedEventCallBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                DebugLog(@"%@",dec);
                NSDictionary *dic = [dec mj_JSONObject];
                NSArray *eventArr = [dic valueForKey:@"event"];
                for (NSDictionary *modelDic in eventArr) {
                    BackLogModel *model = [[BackLogModel alloc] initWithDictionary:modelDic];
                    [self.untreatedArray addObject:model];
                }
                [self.tableView reloadData];
                DebugLog(@"%@",self.untreatedArray);
            }else {
                [weakSelf.view showMessageHud:[dicData valueForKey:@"errmsg"]];
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}

#pragma mark --- 获取当前用户所属部门的用户（不包括他自己）
- (void)getMyManageUsers {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    __weak typeof (self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *netWorkManager = [SAHttpNetworkManager defaultManager];
    [netWorkManager getMyManageUsers:userID callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                DebugLog(@"%@",dec);
                NSArray *dicArr = [dec mj_JSONObject];
                DebugLog(@"%@",dicArr);
                [[NSUserDefaults standardUserDefaults] setObject:dicArr forKey:SA_USERINFO_ManageUsers];

            }else {
                [weakSelf.view showMessageHud:[dicData valueForKey:@"errmsg"]];
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}

#pragma mark --- 获取所有部门的中文名称，部门编码
-(void)getManages {
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager obtainManageCallBack:^(id resp, NSError *error) {
        if (!error) {
            [self.view hideHude];
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSArray *arr = [dec mj_JSONObject];
                
                NSMutableArray *manageArr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in arr) {
                    NSString *manageName = [dic validValueForKey:@"cname"];
                    CSEventManageModel *manageMode = [[CSEventManageModel alloc] initWithDictionary:dic];
                    [manageArr addObject:manageMode];
                }
                
                DebugLog(@"%@",manageArr);
                [[NSUserDefaults standardUserDefaults] setObject:arr forKey:SA_USERINFO_Manages];
                
            }
            else
            {
                NSString *errorMessage = @"获取信息失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                [weakSelf.view showMessageHud:errorMessage];
            }
            
        } else {
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}



- (void)obtainEventDataWithEventId:(NSString *)eventID {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager getUntreatedEvent:userID eventId:eventID callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSDictionary *dic = [dec mj_JSONObject];
                DebugLog(@"%@",dic);
                NSString *dealUsertype = @"";
                NSDictionary *lastDic = [dic validValueForKey:@"last"];
                DebugLog(@"%@",lastDic);
                if ([lastDic isKindOfClass:[NSDictionary class]] || lastDic == NULL || lastDic == nil) {
                    CSBackLogDetailLastModel *lastModel = [[CSBackLogDetailLastModel alloc] initWithDictionary:lastDic];
                    dealUsertype = lastModel.type;
                    DebugLog(@"处理人状态%@",lastModel.type);
                }else {
                    dealUsertype = @"5";
                }
                [[NSUserDefaults standardUserDefaults] setObject:dealUsertype forKey:SA_USERINFO_DealerType];

                CSBackLogDetailViewController *controller = [[CSBackLogDetailViewController alloc]init];
                controller.eventId = eventID;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == 3) {
                [[SAUserInforManager shareManager]logOut];
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate showLoginViewController];
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"待办事项" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
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

#pragma mark  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BackLogModel *model = self.untreatedArray[indexPath.row];
    [self obtainEventDataWithEventId:model.logId];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:[CSBackLogTableViewCell cellIdentifier] configuration:^(id cell) {
    }];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.untreatedArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSBackLogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBackLogTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSBackLogTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBackLogTableViewCell cellIdentifier]];
    }
    [cell initModelData:self.untreatedArray[indexPath.row]];
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
