//
//  SAUserInforManager.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/6.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseModel.h"
typedef enum
{
    ENOThirdLogin = 1,//非三方登录
    EWeChatLogin,//微信登录
    EQQLogin,//qq登录
}ELoginType;

@interface SAUserInforManager : SABaseModel

/*
 * 登录相关
 */
@property(strong, nonatomic)NSError *error;       //错误信息
@property(nonatomic,readonly)BOOL isAuthValid;    //是否可用

/*
 * 用户信息相关
 */

@property(nonatomic)NSInteger state;//服务器返回的状态 0 登录成功 -1失败

@property(nonatomic)NSString* userID; //当前用户的唯一标识
@property(nonatomic, strong)NSString *nickName; //用户昵称
@property(nonatomic, strong)NSString *telNumber; //电话号码，用于登录
@property(nonatomic, strong)NSString *imageUrl;//头像图片链接
@property(nonatomic, strong)NSString *sex;//性别  1 男 2 女
@property(nonatomic, strong)NSString *place;//所在地点
@property(nonatomic, assign)NSInteger isNew;//是否为新用户以判断是登录还是注册 1为是 0为否
//@property(nonatomic, strong)NSString *loginType;//登录方式



//
@property (nonatomic, strong) NSString *rong_token;//token rong_token数据，请求接口时请放在http请求头部
@property (nonatomic, strong) NSString *token;//关联融云token
@property (nonatomic, strong) NSString *head;//暂不知道什么用
@property (nonatomic, strong) NSString *is_sign;//签到？
@property (nonatomic, strong) NSString *manage_cname;
@property (nonatomic, strong) NSString *manage_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *role_cname;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSString *user_id;



//是否已经弹出重新登录弹框
@property(nonatomic)BOOL relogining; //失去权限，但是又还没重新登录


- (BOOL)isAuthValid;

//Other baisc infor

+(SAUserInforManager*)shareManager;

/*
 * 登录
 */
-(void)login:(NSString *)loginName code:(NSString *)code;
-(void)misLogin:(NSString *)loginName code:(NSString *)code;

/*
 * 登出
 */
-(void)logOut;

/*
 * 保存用户信息
 */
-(void)save;

////第三方登录
//-(void)thirdLoginWithType:(NSString *)type;
-(void)showLoginViewController;


@end
