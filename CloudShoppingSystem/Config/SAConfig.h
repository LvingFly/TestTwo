//
//  SAConfig.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIView+Sizes.h"
#import "MBProgressHUD.h"
#import "UIColorCategory.h"
#import "UIViewController+UIRectEdge.h"
#import "UIApplication+UI7.h"
#import "NSError+Extend.h"
#import "SAControlFactory.h"
#import "SADateFormatter.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "UIButton+Factory.h"
#import "MJRefresh.h"
#import "UIButton+EnlargeEdge.h"
#import "AFNetworking.h"
#import "SAHttpNetworkManager.h"
#import "SAHttpsNetworkManager.h"
#import "NSDictionary+RemoveNSNull.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SAUserInforManager.h"
#import "JHChainableAnimations.h" //动画效果
#import "SystemServices.h"
#import "NSString+Extension.h"
#import "CSLoginViewController.h"
#import "MSUIViewExtent.h"
//#import "SAUserInforManager.h"
#import "AESCrypt.h"
#import "PINTextView.h"
#import "ZGLVideoPlyer.h"



#import <RongIMKit/RongIMKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

//系统版本
#define OS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

//手机设备
#define IS_IOS_PHONE (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?YES:NO)

//版本判断
BOOL MSIsiOS7();
BOOL MSIsiOS8();
BOOL MSIsIPhone5();

/*屏高和屏宽，不是实际物理像素，只是用于显示。*/
#define SA_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SA_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SA_SCREEN_HEIGHT_NOSTATUSBAR ([[UIScreen mainScreen] bounds].size.height - 20)
#define SA_TABBAR_HEIGHT 49
#define SA_NAVBAR_HEIGHT 44
#define SA_STATUSBAR_HEIGHT 20
#define SA_NAVBAR_HEIGHT_WITH_STATUS_BAR (SA_NAVBAR_HEIGHT+20)
#define SA_SCREEN_SCALE (SA_SCREEN_WIDTH/375.0)
#define ES_FRAMEHEIGHT(y) (y * SA_SCREEN_HEIGHT / 568.0)
#define ES_FRAMEWIDTH(x) (x * SA_SCREEN_WIDTH / 320.0)

//版本标识，用于判断是否显示启动引导页面
#define KAppGuidedVersion @"appGuidedVerison"

//是否iphone4s屏
#define IS_IPHONE_4S_SCREEN [[UIScreen mainScreen] bounds].size.height>=480.0?YES:NO

//是否iphone5s屏
#define IS_IPHONE_5S_SCREEN [[UIScreen mainScreen] bounds].size.height>=568.0?YES:NO

//是否iphone6屏
#define IS_IPHONE_6_SCREEN [[UIScreen mainScreen] bounds].size.height>=667.0?YES:NO

//是否iphone6plus屏
#define IS_IPHONE_6PLUS_SCREEN [[UIScreen mainScreen] bounds].size.height>=736.0?YES:NO

//测试服务器地址
//#define SA_HTTP_SERVER_ADDRESS @"http://192.168.1.68:8080/mmm/index.php?"

#define SA_HTTP_SERVER_ADDRESS @"http://gowins.imwork.net:8680/mmm/index.php?"


//H5测试服务器地址
#define SA_HTTP_SERVER_HTML5 @"http://192.168.1.115/mallapp/gwKaQuan/client/html/eventDetails.html"

////正式服务器地址
//#define SA_HTTP_SERVER_ADDRESS @"http://ftdb.cdlinglu.com/?"
//#define SA_HTTP_SERVER_IMAGES @"http://ftdb.cdlinglu.com/statics/uploads/"

//无效用户凭证错误码
#define KBad_Token_Error_Code @"0008"
//无效用户凭证通知
#define KBAD_TOKEN_NOTIFICATION @"Bad_Token_Notification"
//无效用户凭证登录返回消息key值
#define KBAD_TOKEN_ERROR_MESSAGE @"Bad_Token_Error_Message"

//版本标识
#define KAppGuidedVersion @"appGuidedVerison"

//操作系统版本是否高于ios8，用于版本判断解决兼容性问题
#define IS_IOS8_OR_HIGHER_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//文件路径
#define Bundle_FILE_PATH(FILE_NAME) [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:FILE_NAME]
#define Document_FILE_PATH(FILE_NAME) [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),FILE_NAME]
#define Library_CACHES_FILE_PATH(FILE_NAME) [NSString stringWithFormat:@"%@/Library/Caches/%@", NSHomeDirectory(),FILE_NAME]

//导航栏相关
#define SA_NavBar_Title_Font_Size 18
#define SA_NavBar_Title_Font_With_Size SA_BoldFontWithSize(SA_NavBar_Title_Font_Size)
#define SA_NavBar_Title_Color SA_Color_HexString(0x000000, 1)

//根据rgba生成color
#define SA_Color_RgbaValue(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

//生成UIColor 十六进制
#define SA_Color_HexString(rgbValue,a) SA_Color_RgbaValue((float)((rgbValue & 0xFF0000) >> 16),(float)((rgbValue & 0xFF00) >> 8),(float)(rgbValue & 0xFF),a)

//系统字体
#define SA_FontWithSize(size) [UIFont systemFontOfSize:size]
#define SA_BoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]

//pingfang字体
#define SA_FontPingFangLightWithSize(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define SA_FontPingFangRegularWithSize(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]

//网络操作正确响应代码
#define KNETWORKOP_RESPONSE_SUCCEED_CODE 0

//加密key
#define kDefaultKey @"gd&#$78wd^454pws" //aes key
//#define kDefault_AES_Iv @"5efd3f6060e20330"

//即时通讯 App Key
#define KRongCloudIMKey @"0vnjpoad0clvz"

//用户信息存储
#define SA_USERINFO_UsreID @"uid"
#define SA_USERINFO_UserName @"username"
#define SA_USERINFO_Mobile @"mobile"
#define SA_USERINFO_ImageUrl @"imageUrl"
#define SA_USERINFO_Sex @"sex"
#define SA_USERINFO_Place @"place"

#define SA_USERINFO_ManageID @"manage_id"
#define SA_USERINFO_UserToken @"token"
#define SA_USERINFO_IMToken @"rong_token"
#define SA_USERINFO_LoginFlag @"flag"

#define SA_USERINFO_DealerType @"dealType"
#define SA_USERINFO_Manages @"manage"

#define SA_USERINFO_ManageUsers @"manageUsers"

#define SA_USERINFO_MisToken @"misToken"



//01 标准色 Colors

#define kHex_Base_Main          0xef544f //主色

#define kHex_Base_Important_01  0x141414 //重要01
#define kHex_Base_Important_02  0x333333 //重要02

#define kHex_Base_Normal_01     0x555555 //一般01
#define kHex_Base_Normal_02     0x999999 //一般02
#define kHex_Base_Normal_03     0xd7d7d7 //一般03

#define kHex_Base_Weak_01       0xe4e4e4 //较弱01
#define kHex_Base_Weak_02       0xeeeeee //较弱02
#define kHex_Base_Weak_03       0xf8f8f8 //较弱03

#define kHex_Base_Assistant_01  0xff9d03 //辅助01
#define kHex_Base_Assistant_02  0x43B695 //辅助02
#define kHex_Base_Assistant_03  0x3996ed //辅助03
#define kHex_Base_Assistant_04  0xffd803 //辅助04

//背景颜色
#define KDefaultBackgroundColor SA_Color_HexString(0xeaeaea, 1)

//字体颜色
#define KDefaultFontColor SA_Color_HexString(0x575757, 1)

//navbar颜色
#define KNavBarColor SA_Color_HexString(0x46a0fc,1)

//基本定义
#define kExchange_Num (750.0 / SA_SCREEN_WIDTH) //基于750P 对比当前屏幕宽度进行像素转换参数
#define kAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kExchange_Num_1080_to_320 (1080.0 / 320.0) //基于1080P 对比屏幕宽度进行像素转换参数
#define kExchange_Num_750 (750.0 / SA_SCREEN_WIDTH) //基于1080P 对比当前屏幕宽度进行像素转换参数
#define kExchange_Num_750_to_320 (750.0 / 320.0) //基于1080P 对比当前屏幕宽度进行像素转换参数

#define KNavBarLeftBtnSpace -8
#define KNavBarRightBtnSpace -8
//aes 加密解密
//    NSString *cc = [AESCrypt encrypt:@"wo卧槽=*-%" password:@"625202f9149e061d"];
//    NSString *dec = [AESCrypt decrypt:cc password:@"625202f9149e061d"];
//    NSLog(@"aes解密    %@xxxx",cc);


@interface SAConfig : NSObject

@end

