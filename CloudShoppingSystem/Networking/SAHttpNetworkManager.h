//
//  SANetworkManager.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/5.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseNetworkManager.h"

/**
 *
 * http网络引擎
 *
 */
@interface SAHttpNetworkManager : SABaseNetworkManager

/*
 *  @brief 获取手机验证码
 *
 *  @param username 手机号
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postPhoneCode:(NSString *)userName CallBack:(SABaseNetworkManagerCallback)callback;

/*
 *  @brief 登录或者注册
 *
 *  @param username 手机号 code 验证码
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postLoginWithUserName:(NSString *)userName code:(NSString *)code callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 更新用户信息
 *
 *  @param uid 用户id head 头像 nickname 昵称 sex 性别 place 居住地
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)updateUserInfoWithUid:(NSString *)userId headImage:(NSString *)headImage nickName:(NSString *)nickName sex:(NSString *)sex place:(NSString *)place callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 获取购物体验列表
 *
 *  @param uid 用户id start_index 页数  count 数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postShopExListWithUid:(NSString *)userId page:(NSString*)startIndex count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 选择购物体验
 *
 *  @param uid 用户id select 选择的体验（8，19，20格式）
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)selectShopExWithUid:(NSString *)userId select:(NSString *)select callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 获取熟悉的品牌列表
 *
 *  @param uid 用户id p 页数 count 每页的数量
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)postFamiliarBrandWithUid:(NSString*)userId startIndex:(NSString *)startIndex count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 选择熟悉的品牌
 *
 *  @param uid 用户id select 选择的品牌（8，19，20格式）
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)selectFamiliarBrandWithUid:(NSString *)userId select:(NSString *)select callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 购物中心列表
 *
 *  @param uid 用户id city 城市
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postMallListWithUid:(NSString *)userId city:(NSString *)city callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 购物中心主页广告中心展示列表
 *
 *  @param  mall_id 购物中心id uid 用户id p 页数  count 每页的数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)mallAdListWithMallid:(NSString *)mallId userId:(NSString *)userId page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 店铺分类列表
 *
 *  @param  mall_id 购物中心id uid 用户id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)storeClassListWithMallId:(NSString *)mallId userId:(NSString *)userId callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 店铺列表
 *
 *  @param  uid 用户id  mall_id 购物中心id  category_id 店铺分类id p 当前页  count每页数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)storeListWithUid:(NSString *)userId mallId:(NSString *)mallId categoryId:(NSString *)categoryId page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief 获取热门搜索关键字列表
 *
 *  @param  无参数
 *
 *  @return	NSURLSessionDataTask
 */

-(NSURLSessionDataTask *)hotSearchKeywordsList:(SABaseNetworkManagerCallback)callBack;

/*
 *  @brief  关键字搜索
 *
 *  @param  keyword 关键字  mallId 购物中心id userId 用户id city城市 page 页数 count 每页数量
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)keywordsSearchWithKeyword:(NSString *)keyword mallId:(NSString *)mallId userId:(NSString *)userId city:(NSString *)city page:(NSString *)page count:(NSString *)count callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 判定是否被收藏
 *
 *  @param  userId 用户id type类型(1为购物中心 2为店铺 3为商品) typeId 类型的id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)isCollectWithUserId:(NSString *)userId type:(NSString *)type typeId:(NSString *)typeId callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取所有的事件分类
 *
 *  @param
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getManagerCallBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取获取部门
 *
 *  @param
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)obtainManageCallBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 登录请求
 *
 *  @param username 用户名 password 用户密码
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)postLoginWithUserName:(NSString *)userName password:(NSString *)password callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取IM聊天好友
 *
 *  @param uid 登录人id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getImFriends:(NSString *)uid token:(NSString *)token callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 提交事件报告 手机端向后台数据库提交事件信息
 *
 *  @param   uid 提交事件人id    eventName 事件名称   explain 事件类型   eventClass 事件分类  location 事件地点   Manage 提交部门处理代码   video 事件视频   pathall 事件图片
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)subEvent:(NSString *)uid eventName:(NSString *)eventName explain:(NSString *)explain eventClass:(NSString *)eventClass location:(NSString *)location manage:(NSString *)manage video:(NSString *)video pathall:(NSString *)pathall  callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 提交事件报告 手机端向后台数据库提交事件信息
 *
 *  @param   uid 提交事件人id    eventName 事件名称   explain 事件类型   eventClass 事件分类  location 事件地点   Manage 提交部门处理代码   video 事件视频   pathall 事件图片
 *
 *  @return	NSURLSessionTask
 */
-(NSURLSessionTask *)photosubEvent:(NSString *)uid eventName:(NSString *)eventName explain:(NSString *)explain eventClass:(NSString *)eventClass location:(NSString *)location manage:(NSString *)manage video:(NSString *)video pathall:(UIImage *)pathall  callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 用户签到
 *
 *  @param uid 签到人登陆后的id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)userSign:(NSString *)uid callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取待办事件列表
 *
 *  @param 
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getUntreatedEventCallBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取事件详情
 *
 *  @param uid 登录人id  event_id 事件id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getUntreatedEvent:(NSString *)uid eventId:(NSString *)eventId callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 获取当前用户所属部门的用户（不包括他自己）
 *
 *  @param uid 登录人id
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getMyManageUsers:(NSString *)uid callBack:(SABaseNetworkManagerCallback)callBack;
//http://192.168.1.68/mm/index.php?s=/Api/Mamber/dealEvent
/*
 *  @brief 事件处理（包含分发，转移，处理）
 *
 *  @param event_id 事件id  fid 上一级事件处理情况id  type 类型  next_id 下一级处理者id  is_continue 是否继续处理  text 备注
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)dealEventWithEventId:(NSString *)eventId Fid:(NSString *)fid Type:(NSString *)type NextId:(NSString *)nextId IsContinue:(NSString *)isContinue Text:(NSString *)text callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 根据谈判编号及登录账号查询指定的谈判记录
 *
 *  @param token 令牌 account 账号 code 谈判编号  currentPage 当前页数  pageSize 每页显示数据条数
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)getNegotiationByCodeAndAccountWithToken:(NSString *)token Account:(NSString *)account Code:(NSString *)code CurrentPage:(NSString *)currentPage PageSize:(NSString *)pageSize callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief MIS登录请求
 *
 *  @param username 用户名 password 用户密码
 *
 *  @return	NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)misPostLoginWithUserName:(NSString *)userName password:(NSString *)password callBack:(SABaseNetworkManagerCallback)callBack;
/*
 *  @brief 图片上传
 *
 *  @param 
 *
 *  @return	NSURLSessionTask
 */
-(NSURLSessionTask *)uploadImage:(UIImage *)image callBack:(SABaseNetworkManagerCallback)callBack;


@end
