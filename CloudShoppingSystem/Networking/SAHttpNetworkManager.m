//
//  SANetworkManager.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/5.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAHttpNetworkManager.h"

@implementation SAHttpNetworkManager

+(instancetype)defaultManager
{
    static SAHttpNetworkManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [SAHttpNetworkManager manager];
    });
    
    return manager;
}

-(NSString*)defaultURLString
{
    return SA_HTTP_SERVER_ADDRESS;
}

-(void)buildParam:(NSMutableDictionary *)params
{
//    NSString* userID = [SAUserInforManager shareManager].loginName;
//    NSString* token = [SAUserInforManager shareManager].token;
//    
//    if (userID == nil) {
//        userID = @"";
//    }
//    
//    if (token == nil) {
//        token = @"";
//    }
//    
//    [params setValue:userID forKey:@"account"];
//    [params setValue:token forKey:@"token"];
//    
//    [params setValue:@"I001" forKey:@"origDomain"];
//    [params setValue:@"" forKey:@"homeDomain"];
//    
//    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
//    NSString* softversion = [infoPlist objectForKey:@"CFBundleVersion"];
//    params[@"version"] = softversion;
//    
//    [params setValue:[[SADateFormatter sharedFormatter] getCurrentTimeStamp] forKey:@"processTime"];
//    [params setValue:[[SystemServices sharedServices] imei] forKey:@"imei"];
}

/*
 *  @brief 获取手机验证码
 *
 *  @param username 手机号
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postPhoneCode:(NSString *)userName CallBack:(SABaseNetworkManagerCallback)callBack
{
    if (userName == nil) {
        userName = @"";
    }
    NSMutableDictionary *params = [@{@"username":userName} mutableCopy];
    
    return [self PostWithPath:@"g=Api1&m=User&a=GetPhoneCode" params:params callback:callBack];
}

/*
 *  @brief 登录或者注册
 *
 *  @param username 手机号 code 验证码
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postLoginWithUserName:(NSString *)userName code:(NSString *)code callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userName == nil) {
        userName = @"";
    }
    if (code == nil) {
        code = @"";
    }
    NSMutableDictionary *params = [@{@"username":userName, @"code":code} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=User&a=Login" params:params callback:callBack];
}

/*
 *  @brief 更新用户信息
 *
 *  @param uid 用户id head 头像 nickname 昵称 sex 性别 place 居住地
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)updateUserInfoWithUid:(NSString *)userId headImage:(NSString *)headImage nickName:(NSString *)nickName sex:(NSString *)sex place:(NSString *)place callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"52";
    }
    if (headImage == nil) {
        headImage = @"";
    }
    if (nickName == nil) {
        nickName = @"";
    }
    if (sex == nil) {
        sex = @"";
    }
    if (place == nil) {
        place = @"";
    }
    
    NSMutableDictionary *params = [@{@"uid":userId, @"head":headImage, @"nickname":nickName, @"sex":sex,@"place":place} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=User&a=UpdateUserInfo" params:params callback:callBack];
}

/*
 *  @brief 获取购物体验列表
 *
 *  @param uid 用户id p 页数  count 数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postShopExListWithUid:(NSString *)userId page:(NSString*)pageCount count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"52";
    }
    if (pageCount == nil) {
        pageCount = @"";
    }
    if (count == nil) {
        count = @"";
    }
    NSMutableDictionary *params = [@{@"uid":userId,@"p":pageCount,@"count":count} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=ShoppingTypeList" params:params callback:callBack];
}

/*
 *  @brief 选择购物体验
 *
 *  @param uid 用户id select 选择的体验（8，19，20格式）
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)selectShopExWithUid:(NSString *)userId select:(NSString *)select callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"52";
    }
    if (select == nil) {
        select = @"";
    }
    
    NSMutableDictionary *params = [@{@"uid":userId,@"select":select} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=SelectShoppingType" params:params callback:callBack];
}

/*
 *  @brief 获取熟悉的品牌列表
 *
 *  @param uid 用户id start_index count 数量
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postFamiliarBrandWithUid:(NSString*)userId startIndex:(NSString *)startIndex count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"52";
    }
    if (startIndex == nil) {
        startIndex = @"";
    }
    if (count == nil) {
        count = @"";
    }
    
    NSMutableDictionary *params =[@{@"uid":userId,@"start_index":startIndex,@"count":count} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=BrandList" params:params callback:callBack];
}

/*
 *  @brief 选择熟悉的品牌
 *
 *  @param uid 用户id select  选择的品牌（8，19，20格式）
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)selectFamiliarBrandWithUid:(NSString *)userId select:(NSString *)select callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"52";
    }
    if (select == nil) {
        select = @"";
    }
    
    NSMutableDictionary *params = [@{@"uid":userId,@"select":select} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=SelectBrand" params:params callback:callBack];
}

/*
 *  @brief 购物中心列表
 *
 *  @param uid 用户id city 城市
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postMallListWithUid:(NSString *)userId city:(NSString *)city callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"";
    }
    if (city == nil) {
        city = @"";
    }
    
    NSMutableDictionary *params = [@{@"uid":userId,@"city":city} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=Malls" params:params callback:callBack];
}

/*
 *  @brief 购物中心主页广告中心展示列表
 *
 *  @param  mall_id 购物中心id uid 用户id p 页数  count 每页的数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)mallAdListWithMallid:(NSString *)mallId userId:(NSString *)userId page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack
{
    if (mallId == nil) {
        mallId = @"";
    }
    
    if (userId == nil) {
        userId = @"";
    }
    
    if (page == nil) {
        page = @"";
    }
    
    if (count == nil) {
        count = @"";
    }
    
    NSMutableDictionary *params = [@{@"mall_id":mallId,@"uid":userId,@"p":page,@"count":count} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=AdList" params:params callback:callBack];
}

/*
 *  @brief 店铺分类列表
 *
 *  @param  mall_id 购物中心id uid 用户id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)storeClassListWithMallId:(NSString *)mallId userId:(NSString *)userId callBack:(SABaseNetworkManagerCallback)callBack
{
    if (mallId == nil) {
        mallId = @"";
    }
    
    if (userId == nil) {
        userId = @"";
    }
    
    NSMutableDictionary *params = [@{@"mall_id":mallId,@"uid":userId} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=StoreCategory" params:params callback:callBack];
}

/*
 *  @brief 店铺列表
 *
 *  @param  uid 用户id  mall_id 购物中心id  category_id 店铺分类id p 当前页  count每页数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)storeListWithUid:(NSString *)userId mallId:(NSString *)mallId categoryId:(NSString *)categoryId page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack
{
    if (mallId == nil) {
        mallId = @"";
    }
    
    if (userId == nil) {
        userId = @"";
    }
    
    if (categoryId == nil) {
        categoryId = @"";
    }
    
    if (page == nil) {
        page = @"";
    }
    
    if (count == nil) {
        count = @"";
    }
    
    NSMutableDictionary *params = [@{@"mall_id":mallId,@"uid":userId,@"category_id":categoryId,@"p":page,@"count":count} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=StoreGroup" params:params callback:callBack];
}

/*
 *  @brief 获取热门搜索关键字列表
 *
 *  @param  无参数
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)hotSearchKeywordsList:(SABaseNetworkManagerCallback)callBack
{
    NSMutableDictionary *params = [@{ }mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=HotSearch" params:params callback:callBack];
}

/*
 *  @brief  关键字搜索
 *
 *  @param  keyword 关键字  mallId 购物中心id userId 用户id city城市 page 页数 count 每页数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)keywordsSearchWithKeyword:(NSString *)keyword mallId:(NSString *)mallId userId:(NSString *)userId city:(NSString *)city page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack
{
    if (mallId == nil) {
        mallId = @"";
    }
    
    if (userId == nil) {
        userId = @"8";
    }
    
    if (keyword == nil) {
        keyword = @"";
    }
    
    if (city == nil) {
        city = @"";
    }
    
    if (page == nil) {
        page = @"";
    }
    
    if (count == nil) {
        count = @"";
    }
    
    NSMutableDictionary *params = [@{@"mall_id":mallId,@"uid":userId,@"city":city,@"keyword":keyword,@"p":page,@"count":count} mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=StoreSearch" params:params callback:callBack];
}

/*
 *  @brief 判定是否被收藏
 *
 *  @param  userId 用户id type类型(1为购物中心 2为店铺 3为商品) typeId 类型的id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)isCollectWithUserId:(NSString *)userId type:(NSString *)type typeId:(NSString *)typeId callBack:(SABaseNetworkManagerCallback)callBack
{
    if (userId == nil) {
        userId = @"";
    }
    
    if (type == nil) {
        type = @"";
    }
    
    if (typeId == nil) {
        typeId = @"";
    }
    
    NSMutableDictionary *params = [@{@"uid":userId,@"type":type,@"type_id":typeId}mutableCopy];
    return [self PostWithPath:@"g=Api1&m=Mall&a=IsCollect" params:params callback:callBack];
}
/*
 *  @brief 获取所有的事件分类
 *
 *  @param
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getManagerCallBack:(SABaseNetworkManagerCallback)callBack{
    NSMutableDictionary *params = [@{}mutableCopy];
    return [self PostWithPath:@"s=/Api/Member/getEventClass" params:params callback:callBack];
}
/*
 *  @brief 获取获取部门
 *
 *  @param
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)obtainManageCallBack:(SABaseNetworkManagerCallback)callBack {
    NSMutableDictionary *params = [@{}mutableCopy];
    return [self PostWithPath:@"s=/Api/Member/getManage" params:params callback:callBack];

}
/*
 *  @brief 登录请求
 *
 *  @param username 用户名 password 用户密码
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postLoginWithUserName:(NSString *)userName password:(NSString *)password callBack:(SABaseNetworkManagerCallback)callBack {
    NSString *username = [AESCrypt encrypt:userName password:kDefaultKey];
    NSString *passWord = [AESCrypt encrypt:password password:kDefaultKey];

    NSMutableDictionary *params = [@{@"username":username,@"password":passWord} mutableCopy];
    return [self PostWithPath:@"s=/Api/Member/login" params:params callback:callBack];
}
/*
 *  @brief 获取IM聊天好友
 *
 *  @param uid 登录人id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getImFriends:(NSString *)uid token:(NSString *)token callBack:(SABaseNetworkManagerCallback)callBack {
//    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UserToken];
    NSMutableDictionary *params = [@{@"uid":uid} mutableCopy];
    return [self HeaderPostWithPath:@"s=/Api/Member/getImFriends" params:params callback:callBack];
}
/*
 *  @brief 提交事件报告 手机端向后台数据库提交事件信息
 *
 *  @param   uid 提交事件人id    eventName 事件名称   explain 事件类型   eventClass 事件分类  location 事件地点   Manage 提交部门处理代码   video 事件视频   pathall 事件图片
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)subEvent:(NSString *)uid eventName:(NSString *)eventName explain:(NSString *)explain eventClass:(NSString *)eventClass location:(NSString *)location manage:(NSString *)manage video:(NSString *)video pathall:(NSString *)pathall  callBack:(SABaseNetworkManagerCallback)callBack {
    
    NSString *userID = [AESCrypt encrypt:uid password:kDefaultKey];
    NSString *event_Name = [AESCrypt encrypt:eventName password:kDefaultKey];
    NSString *ex_plain = [AESCrypt encrypt:explain password:kDefaultKey];
    NSString *event_Class = [AESCrypt encrypt:eventClass password:kDefaultKey];
    NSString *loca_tion = [AESCrypt encrypt:location password:kDefaultKey];
    NSString *mana_ge = [AESCrypt encrypt:manage password:kDefaultKey];
    NSString *vide_o = [AESCrypt encrypt:video password:kDefaultKey];
    NSString *path_all = [AESCrypt encrypt:pathall password:kDefaultKey];
    
    NSMutableDictionary *params = [@{@"eventName":event_Name,@"explain":ex_plain,@"eventClass":event_Class,@"location":loca_tion,@"Manage":mana_ge,@"video":vide_o,@"pathall":path_all} mutableCopy];

    return [self HeaderPostWithPath:@"s=/Api/Member/subEvent" params:params callback:callBack];
}
/*
 *  @brief 提交事件报告 手机端向后台数据库提交事件信息
 *
 *  @param   uid 提交事件人id    eventName 事件名称   explain 事件类型   eventClass 事件分类  location 事件地点   Manage 提交部门处理代码   video 事件视频   pathall 事件图片
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionTask *)photosubEvent:(NSString *)uid eventName:(NSString *)eventName explain:(NSString *)explain eventClass:(NSString *)eventClass location:(NSString *)location manage:(NSString *)manage video:(NSString *)video pathall:(UIImage *)pathall  callBack:(SABaseNetworkManagerCallback)callBack {
    NSString *userID = [AESCrypt encrypt:uid password:kDefaultKey];
    NSString *event_Name = [AESCrypt encrypt:eventName password:kDefaultKey];
    NSString *ex_plain = [AESCrypt encrypt:explain password:kDefaultKey];
    NSString *event_Class = [AESCrypt encrypt:eventClass password:kDefaultKey];
    NSString *loca_tion = [AESCrypt encrypt:location password:kDefaultKey];
    NSString *mana_ge = [AESCrypt encrypt:manage password:kDefaultKey];
    NSString *vide_o = [AESCrypt encrypt:video password:kDefaultKey];
    NSString *path_all = [AESCrypt encrypt:pathall password:kDefaultKey];

    
    NSMutableDictionary *params = [@{@"uid":userID,@"eventName":event_Name,@"explain":ex_plain,@"eventClass":event_Class,@"location":loca_tion,@"manage":mana_ge,@"video":vide_o,@"pathall":path_all} mutableCopy];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss-SSS";
    NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
    
    return [self singalUploadWithURL:@"s=/Api/Member/subEvent" parameters:params image:pathall name:@"Filedata" fileName:fileName mimeType:@"image/png" progress:^(NSProgress *progress) {
        
    } callBack:callBack];
}




/*
 *  @brief 用户签到
 *
 *  @param uid 签到人登陆后的id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)userSign:(NSString *)uid callBack:(SABaseNetworkManagerCallback)callBack {
    NSMutableDictionary *params = [@{@"uid":uid} mutableCopy];
        return [self HeaderPostWithPath:@"s=/Api/Member/sign" params:params callback:callBack];
}
/*
 *  @brief 获取待办事件列表
 *
 *  @param uid 登录人id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getUntreatedEventCallBack:(SABaseNetworkManagerCallback)callBack {
    NSMutableDictionary *params = [@{} mutableCopy];
    return [self HeaderPostWithPath:@"s=/Api/Member/getUntreatedEvent" params:params callback:callBack];
}
/*
 *  @brief 获取事件详情
 *
 *  @param uid 登录人id  event_id 事件id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getUntreatedEvent:(NSString *)uid eventId:(NSString *)eventId callBack:(SABaseNetworkManagerCallback)callBack {
    NSString *event_Id = [AESCrypt encrypt:eventId password:kDefaultKey];
    NSMutableDictionary *params = [@{@"event_id":event_Id} mutableCopy];
    return [self HeaderPostWithPath:@"s=/Api/Member/getEventDetail" params:params callback:callBack];
}
/*
 *  @brief 获取当前用户所属部门的用户（不包括他自己）
 *
 *  @param uid 登录人id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getMyManageUsers:(NSString *)uid callBack:(SABaseNetworkManagerCallback)callBack {
    NSString *u_id = [AESCrypt encrypt:uid password:kDefaultKey];
    NSMutableDictionary *params = [@{@"uid":u_id} mutableCopy];
    return [self HeaderPostWithPath:@"s=/Api/Member/getMyManageUsers" params:params callback:callBack];
}

/*
 *  @brief 事件处理（包含分发，转移，处理）
 *
 *  @param event_id 事件id  fid 上一级事件处理情况id  type 类型  next_id 下一级处理者id  is_continue 是否继续处理  text 备注
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)dealEventWithEventId:(NSString *)eventId Fid:(NSString *)fid Type:(NSString *)type NextId:(NSString *)nextId IsContinue:(NSString *)isContinue Text:(NSString *)text callBack:(SABaseNetworkManagerCallback)callBack {
//    NSString *u_id = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
//    NSString *uid = [AESCrypt encrypt:u_id password:kDefaultKey];
    NSString *event_id = [AESCrypt encrypt:eventId password:kDefaultKey];
    NSString *Fid = [AESCrypt encrypt:fid password:kDefaultKey];
    NSString *Type = [AESCrypt encrypt:type password:kDefaultKey];
    NSString *next_id = [AESCrypt encrypt:nextId password:kDefaultKey];
    NSString *IsContinue = [AESCrypt encrypt:isContinue password:kDefaultKey];
    NSString *Text = [AESCrypt encrypt:text password:kDefaultKey];

    NSMutableDictionary *params = [@{@"event_id":event_id,@"fid":Fid,@"type":Type,@"next_id":next_id,@"is_continue":IsContinue,@"text":Text} mutableCopy];
    return [self HeaderPostWithPath:@"s=/Api/Member/dealEvent" params:params callback:callBack];
}




/*
 *  @brief 根据谈判编号及登录账号查询指定的谈判记录
 *
 *  @param token 令牌 account 账号 code 谈判编号  currentPage 当前页数  pageSize 每页显示数据条数
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getNegotiationByCodeAndAccountWithToken:(NSString *)token Account:(NSString *)account Code:(NSString *)code CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize callBack:(SABaseNetworkManagerCallback)callBack {

    int CurrentPage = currentPage.intValue;
    int PageSize = pageSize.intValue;
    
    NSMutableDictionary *params = [@{@"token":token,@"account":account,@"currentPage":@(CurrentPage),@"pageSize":@(PageSize)} mutableCopy];
    return [self MISPostWithPath:@"getNegotiationByCodeAndAccount.do" params:params callback:callBack];
    
}
/*
 *  @brief MIS登录请求
 *
 *  @param username 用户名 password 用户密码
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)misPostLoginWithUserName:(NSString *)userName password:(NSString *)password callBack:(SABaseNetworkManagerCallback)callBack {
    NSMutableDictionary *params = [@{@"account":userName,@"password":password} mutableCopy];
    return [self MISPostWithPath:@"getToken.do" params:params callback:callBack];
}


/*
 *  @brief 图片上传
 *
 *  @param
 *
 *  @return	NSURLSessionTask
 */
-(NSURLSessionTask *)uploadImage:(UIImage *)image callBack:(SABaseNetworkManagerCallback)callBack {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSMutableDictionary *params = [@{} mutableCopy];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    
    NSString *str = [formatter stringFromDate:[NSDate date]];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];

    return [self singalUploadWithURL:@"s=/Api/Member/uploadImg" parameters:params image:image name:@"photos" fileName:fileName mimeType:@"image/png" progress:^(NSProgress *progress) {
        
    } callBack:callBack];
}






@end
