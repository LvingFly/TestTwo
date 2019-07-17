//
//  SAUserInforManager.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/6.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAUserInforManager.h"
#import "SNNavigationController.h"
#import "CSLoginViewController.h"
#import "AppDelegate.h"




//#define SA_USERINFO_UserRight @"SA_USERINFO_UserRight"

@implementation SAUserInforManager

+(SAUserInforManager*)shareManager{
    
    static SAUserInforManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[SAUserInforManager alloc] init];
    });
    
    return manager;
}

-(id)init
{
    if (self = [super init]) {
        //获取账号信息
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
        _nickName= [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UserName];
        _telNumber = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_Mobile];
        _imageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_ImageUrl];
        _sex = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_Sex];
        _place = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_Place];
    }
    return self;
}

//登录是否有效，是否授权
- (BOOL)isAuthValid{
    BOOL isValid = NO;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_LoginFlag]) {
        isValid = YES;
    }
    
    return isValid;
}

/*
 * 登录
 */
-(void)login:(NSString *)loginName code:(NSString *)code
{
    __weak typeof(self) weakSelf = self;
        SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate setBadegePassNumIsFresh];
    return;

    self.dataTask = [networkManager postLoginWithUserName:loginName password:code callBack:^(id resp, NSError *error)
    {
        if (!error){
            
            
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]]?(NSDictionary*)resp:nil;
        DebugLog(@"%@",dicData);
            if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 0) {
                //提取想要的信息
                NSString* dataDic = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:dataDic password:kDefaultKey];
                NSDictionary *dataDicR = [dec mj_JSONObject];
                DebugLog(@"dataDicR------>%@",dataDicR);
            weakSelf.token = [dicData validValueForKey:@"token"];
            weakSelf.rong_token = [dicData valueForKey:@"rong_token"];//融云所需要的token
            weakSelf.head = [dataDicR validValueForKey:@"head"];
            weakSelf.is_sign = [NSString stringWithFormat:@"%@",[dataDicR validValueForKey:@"is_sign"]];
            weakSelf.manage_cname = [dataDicR validValueForKey:@"manage_cname"];
            weakSelf.is_sign = [NSString stringWithFormat:@"%@",[dataDicR validValueForKey:@"manage_id"]];
            weakSelf.nickName = [dataDicR validValueForKey:@"nickname"];
            weakSelf.role_cname = [dataDicR validValueForKey:@"role_cname"];
            weakSelf.role_id = [NSString stringWithFormat:@"%@",[dataDicR validValueForKey:@"role_id"]];
            weakSelf.user_id = [NSString stringWithFormat:@"%@",[dataDicR validValueForKey:@"user_id"]];
                
                [weakSelf save];
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [delegate setBadegePassNumIsFresh];
            }
            else{
                if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 1) {
                        NSString *errorMessage = @"登录失败";
                        if ([dicData validValueForKey:@"errmsg"]) {
                            errorMessage = [dicData validValueForKey:@"errmsg"];
                        }
                        [weakSelf logOut];
                        weakSelf.error = [NSError errorWithDomain:@"unknown"
                                                             code:-1
                                                         userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
                }
            }
        }
        else{
            NSString *errorMessage = @"登录失败，请重试！";
            if ([error code] == KNoNetWorkErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            weakSelf.error = [NSError errorWithDomain:@"unknown"
                                                 code:[error code]
                                             userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
        }
    }];
}
/*
 * MIS 登录
 */
-(void)misLogin:(NSString *)loginName code:(NSString *)code
{
    __weak typeof(self) weakSelf = self;
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    self.dataTask = [networkManager misPostLoginWithUserName:loginName password:code callBack:^(id resp, NSError *error)
                     {
                         
                         if (!error){
                             NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]]?(NSDictionary*)resp:nil;
                             DebugLog(@"%@",dicData);
                             NSString *misToken = [dicData validValueForKey:@"data"];
                             [[NSUserDefaults standardUserDefaults] setObject:misToken forKey:SA_USERINFO_MisToken];
                             NSDictionary* dataDic = [dicData validValueForKey:@"status"];
                             if (dataDic && [[dataDic validValueForKey:@"errcode"] integerValue] == 10000) {
                                 
                             }else {
                                 
                             }
                         }
                         else{
                             NSString *errorMessage = @"登录失败，请重试！";
                             if ([error code] == KNoNetWorkErrorCode)
                             {
                                 errorMessage = @"网络已断开，请检查您的网络连接！";
                             }
                             weakSelf.error = [NSError errorWithDomain:@"unknown"
                                                                  code:[error code]
                                                              userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
                         }
                     }];
    
}



/*
 * 保存用户信息
 */
-(void)save{
    [[NSUserDefaults standardUserDefaults] setObject:self.user_id forKey:SA_USERINFO_UsreID];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.telNumber forKey:SA_USERINFO_Mobile];
    [[NSUserDefaults standardUserDefaults] setObject:self.nickName forKey:SA_USERINFO_UserName];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.imageUrl forKey:SA_USERINFO_ImageUrl];
    [[NSUserDefaults standardUserDefaults] setObject:self.sex forKey:SA_USERINFO_Sex];
    [[NSUserDefaults standardUserDefaults] setObject:self.place forKey:SA_USERINFO_Place];

    [[NSUserDefaults standardUserDefaults] setObject:self.manage_id forKey:SA_USERINFO_ManageID];
    [[NSUserDefaults standardUserDefaults] setObject:self.token forKey:SA_USERINFO_UserToken];
    [[NSUserDefaults standardUserDefaults] setObject:self.rong_token forKey:SA_USERINFO_IMToken];

    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:SA_USERINFO_LoginFlag];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 * 登出
 */
-(void)logOut{
    self.nickName = nil;
    self.userID = nil;
    self.telNumber = nil;
    self.imageUrl = nil;
    self.sex = nil;
    self.place = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_UsreID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_UserName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_Mobile];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_ImageUrl];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_Sex];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_Place];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_ManageID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_UserToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_LoginFlag];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SA_USERINFO_IMToken];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(void)showLoginViewController
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *controller = (UIViewController *)[[delegate window] rootViewController];
    if (controller) {
        CSLoginViewController *loginViewController = [CSLoginViewController new];
        SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:loginViewController];
        [nav setNavBarBgWithColor:[UIColor whiteColor]];
        [controller presentViewController:nav animated:YES completion:nil];
    }
    


}


@end
