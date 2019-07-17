//
//  CSChatListViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//#define SA_USERINFO_IMToken @"rong_token"


#import "CSChatListViewController.h"

#import "CSIMFriendsViewController.h"
#import "CSChatListItem.h"

@interface CSChatListViewController ()
@property (nonatomic, strong) NSString *IMToken;
@property (nonatomic, strong) NSString *Uid;

@end

@implementation CSChatListViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.conversationListTableView.frame = CGRectMake(0, 64, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT-64-49);
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
    
    [self initNavButtons];
    
    
    

    
    
    
}


-(void)initNavButtons
{
    UILabel *titleLabel = [SAControlFactory createLabel:@"我的消息" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    
    UIButton *addressBook = [UIButton buttonWithType:UIButtonTypeSystem];
    addressBook.backgroundColor = [UIColor clearColor];
    [addressBook setTitle:@"通讯录" forState:UIControlStateNormal];
    [addressBook setTintColor:[UIColor whiteColor]];
    addressBook.titleLabel.font = [UIFont systemFontOfSize:15];
    [addressBook sizeToFit];
    addressBook.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    addressBook.top = (SA_SCREEN_HEIGHT - addressBook.height)/2;
    [addressBook addTarget:self action:@selector(addressBookButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:addressBook];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _IMToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_IMToken];
    
    [[RCIM sharedRCIM] connectWithToken:_IMToken success:^(NSString *userId) {
        
        
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        
        
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title =model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

#pragma mark  button Events
-(void)addressBookButtonClicked:(UIButton *)sender {
    
    _Uid = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    _IMToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_IMToken];

    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中..."];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    
    [networkManager getImFriends:_Uid token:_IMToken callBack:^(id resp, NSError *error) {
        if (!error){
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]]?(NSDictionary*)resp:nil;
            
            if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 0) {
                //提取想要的信息
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSArray *arr = [dec mj_JSONObject];
                DebugLog(@"%@",arr);

                
                NSMutableArray *listArr = [NSMutableArray array];//装部门信息模型的数组
                for (NSDictionary *itemDic in arr) {
                    CSChatListItem *item = [[CSChatListItem alloc] initWithDictionary:itemDic];
                    [listArr addObject:item];
                }
                
                
                CSIMFriendsViewController *vc = [[CSIMFriendsViewController alloc] init];
                vc.friendsListArr = listArr;
                vc.dataArr = arr;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:true];
            }else{
                if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 3) {
                    NSString *errorMessage = @"登录失败";
                    if ([dicData validValueForKey:@"errmsg"]) {
                        errorMessage = [dicData validValueForKey:@"errmsg"];
                    }
                    
                    [weakSelf.view showMessageHud:errorMessage];
                    
                }
            }
        }
        else{
            NSString *errorMessage = @"登录失败，请重试！";
            if ([error code] == KNoNetWorkErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            
            [weakSelf.view showMessageHud:errorMessage];

        }
        
    
    }];
    
//    IMFriendsViewController *vc = [[IMFriendsViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:nil];
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
