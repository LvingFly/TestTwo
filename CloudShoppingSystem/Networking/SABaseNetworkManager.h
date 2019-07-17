//
//  SANetworkManager.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/5.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

typedef NS_ENUM(NSUInteger, PPNetworkStatus) {
    /** 未知网络*/
    PPNetworkStatusUnknown,
    /** 无网络*/
    PPNetworkStatusNotReachable,
    /** 手机网络*/
    PPNetworkStatusReachableViaWWAN,
    /** WIFI网络*/
    PPNetworkStatusReachableViaWiFi
};

/** 网络状态的Block*/
typedef void(^NetworkStatus)(PPNetworkStatus status);

/** 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小*/
typedef void (^HttpProgress)(NSProgress *progress);

//返回结果block
typedef void (^SABaseNetworkManagerCallback)(id resp, NSError *error);

/**
 *
 * 网络引擎基类
 *
 */
@interface SABaseNetworkManager : AFHTTPSessionManager

+ (instancetype)defaultManager;

-(NSString * const)defaultURLString; //默认的服务器地址

-(void)buildParam:(NSMutableDictionary *)params;//需要自定义默认参数请复写此方法

/**
 *  实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+(void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/**
 *  一次性获取当前网络状态,有网YES,无网:NO
 */
+ (BOOL)currentNetworkStatus;

-(NSURLSessionDataTask*)GetWithPath:(NSString*) path //GET方法
                               params:(NSMutableDictionary *)params
                             callback:(SABaseNetworkManagerCallback)callback;

-(NSURLSessionDataTask*)PostWithPath:(NSString*) path //POST方法
                                params:(NSMutableDictionary *)params
                              callback:(SABaseNetworkManagerCallback)callback;

-(NSURLSessionDataTask*)HeaderPostWithPath:(NSString*) path //IMPOST方法
                              params:(NSMutableDictionary *)params
                            callback:(SABaseNetworkManagerCallback)callback;

-(NSURLSessionDataTask*)MISPostWithPath:(NSString*) path //POST方法
                                 params:(NSMutableDictionary *)params
                               callback:(SABaseNetworkManagerCallback)callback;

-(NSURLSessionTask *)uploadWithURL:(NSString *)path
                        parameters:(NSMutableDictionary *)params
                            images:(NSArray<UIImage *> *)images
                              name:(NSString *)name
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                          progress:(HttpProgress)progress
                          callBack:(SABaseNetworkManagerCallback)callBack;//上传图片


#pragma mark - 上传图片文件
-(NSURLSessionTask *)singalUploadWithURL:(NSString *)path
                              parameters:(NSMutableDictionary *)params
                                   image:(UIImage *)image
                                    name:(NSString *)name
                                fileName:(NSString *)fileName
                                mimeType:(NSString *)mimeType
                                progress:(HttpProgress)progress
                                callBack:(SABaseNetworkManagerCallback)callBack;
@end
