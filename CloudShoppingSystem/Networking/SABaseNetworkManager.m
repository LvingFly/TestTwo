//
//  SANetworkManager.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/5.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseNetworkManager.h"

@implementation SABaseNetworkManager

static BOOL _isNetwork;

+ (instancetype)defaultManager;
{
    return nil;
}

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(PPNetworkStatusUnknown) : nil;
                    _isNetwork = NO;
                    DebugLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(PPNetworkStatusNotReachable) : nil;
                    _isNetwork = NO;
                    DebugLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWWAN) : nil;
                    _isNetwork = YES;
                    DebugLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWiFi) : nil;
                    _isNetwork = YES;
                    DebugLog(@"WIFI");
                    break;
            }
        }];
        [manager startMonitoring];
    });
}

+ (BOOL)currentNetworkStatus
{
    return _isNetwork;
}

-(NSString *)defaultURLString
{
    return nil;
}

-(void)buildParam:(NSMutableDictionary *)params
{
    return;
}

-(NSURLSessionDataTask*)GetWithPath:(NSString*) path //GET方法
                               params:(NSMutableDictionary *)params
                             callback:(SABaseNetworkManagerCallback)callback
{
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    //完善请求链接
    NSString* urlString = [[self defaultURLString] stringByAppendingString:path];
    DebugLog(@"urlString:%@",urlString);
    __weak typeof(self) weakSelf = self;
    return [self GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.response);
        callback(task.response, error);
    }];
}

-(NSURLSessionDataTask*)PostWithPath:(NSString*) path //POST方法
                                params:(NSMutableDictionary *)params
                              callback:(SABaseNetworkManagerCallback)callback
{
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
    
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    DebugLog(@"%@",params);
    
    //完善请求链接
    NSString* urlString = [[self defaultURLString] stringByAppendingString:path];
    
    DebugLog(@"urlString:%@",urlString);
    
    __weak typeof(self) weakSelf = self;
    
    return [self POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.response);
        callback(task.response, error);
    }];
}

-(NSURLSessionDataTask*)HeaderPostWithPath:(NSString*) path //POST方法
                              params:(NSMutableDictionary *)params
                            callback:(SABaseNetworkManagerCallback)callback
{
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UserToken];
//    NSString *rong_token = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_IMToken];

    [self.requestSerializer setValue:userToken forHTTPHeaderField:@"token"];
//    [self.requestSerializer setValue:rong_token forHTTPHeaderField:@"rong_token"];
    
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    DebugLog(@"%@",params);
    
    //完善请求链接
    NSString* urlString = [[self defaultURLString] stringByAppendingString:path];
    
    DebugLog(@"urlString:%@",urlString);
    
    __weak typeof(self) weakSelf = self;
    
    return [self POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.response);
        callback(task.response, error);
    }];
}



-(NSURLSessionDataTask*)MISPostWithPath:(NSString*) path //POST方法
                                    params:(NSMutableDictionary *)params
                                  callback:(SABaseNetworkManagerCallback)callback
{
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
//    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UserToken];
//    [self.requestSerializer setValue:userToken forHTTPHeaderField:@"token"];
    
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    DebugLog(@"%@",params);
    
    NSString *misUrl = @"http://273644.cicp.net:8351/misApi/";
//    NSString *misUrl = @"http://192.168.1.123:8080/misApi/";
    
    //完善请求链接
    NSString* urlString = [misUrl stringByAppendingString:path];
    DebugLog(@"urlString:%@",urlString);
    __weak typeof(self) weakSelf = self;
    return [self POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.response);
        callback(task.response, error);
    }];
}







#pragma mark - 上传图片文件
-(NSURLSessionTask *)uploadWithURL:(NSString *)path
                         parameters:(NSMutableDictionary *)params
                             images:(NSArray<UIImage *> *)images
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mimeType:(NSString *)mimeType
                           progress:(HttpProgress)progress
                           callBack:(SABaseNetworkManagerCallback)callBack
{
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    //完善请求链接
    NSString* urlString = [[self defaultURLString] stringByAppendingString:path];
    
    DebugLog(@"urlString:%@",urlString);
    __weak typeof(self) weakSelf = self;
    
    return [self POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.response);
        callBack(task.response, error);
    }];
}




#pragma mark - 上传图片文件
-(NSURLSessionTask *)singalUploadWithURL:(NSString *)path
                        parameters:(NSMutableDictionary *)params
                            image:(UIImage *)image
                              name:(NSString *)name
                          fileName:(NSString *)fileName
                          mimeType:(NSString *)mimeType
                          progress:(HttpProgress)progress
                          callBack:(SABaseNetworkManagerCallback)callBack
{
    self.securityPolicy.allowInvalidCertificates = YES;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"application/javascript", @"text/plain",nil];//设置相应内容类型
    self.requestSerializer.timeoutInterval = 30.0f;
    //打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //添加上默认参数
    [self buildParam:params];
    
    //完善请求链接
    NSString* urlString = [[self defaultURLString] stringByAppendingString:path];
    
    DebugLog(@"urlString:%@",urlString);
    __weak typeof(self) weakSelf = self;
    
    return [self POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //压缩-添加-上传图片
            NSData *imageData = UIImageJPEGRepresentation(image, 2);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@.%@",fileName,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType ? mimeType : @"jpeg"]];
                
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *responseString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        DebugLog(@"urlString:%@ ----------------------------------\n response string:%@\n----------------------------------",urlString, responseString);
        [weakSelf disposalReceiveDataWithCallback:responseObject callback:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
        NSLog(@"%@", task.response);
        callBack(task.response, error);
    }];
}


-(void)disposalReceiveDataWithCallback:(id)responseObject callback:(SABaseNetworkManagerCallback)callback
{
    //统一处理0008错误
    NSDictionary *dicData = [responseObject isKindOfClass:[NSDictionary class]]?(NSDictionary*)responseObject:nil;
    //用户被禁用
    NSDictionary* headerDic = [dicData objectForKey:@"header"];
    headerDic = [headerDic isKindOfClass:[NSDictionary class]] ? (NSDictionary*)headerDic : nil;
    if (headerDic && [headerDic valueForKeyPath:@"rspCode"] != nil && [[headerDic valueForKeyPath:@"rspCode"] isEqualToString:KBad_Token_Error_Code]) {
        
        NSString *message = [headerDic valueForKeyPath:@"rspDesc"];
        
        if (!message) {
            message = @"您的帐号已在其它地方登录！";
        }
        
        NSDictionary *notifacationDic = @{KBAD_TOKEN_ERROR_MESSAGE : message};
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:KBAD_TOKEN_NOTIFICATION object:nil userInfo:notifacationDic];
        });
    }
    else {
        callback(responseObject, nil);
    }
}


@end
