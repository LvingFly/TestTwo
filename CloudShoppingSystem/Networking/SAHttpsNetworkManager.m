//
//  SAHttpsNetworkManager.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/6.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAHttpsNetworkManager.h"

@implementation SAHttpsNetworkManager

+(instancetype)defaultManager
{
    static SAHttpsNetworkManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [SAHttpsNetworkManager manager];
    });
    
    return manager;
}

-(NSString*)defaultURLString
{
    return SA_HTTP_SERVER_ADDRESS;
}

//-(void)buildParam:(NSMutableDictionary *)params
//{
//    [params setValue:@"I001" forKey:@"origDomain"];
//    [params setValue:@"" forKey:@"homeDomain"];
//    
//    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
//    NSString* softversion = [infoPlist objectForKey:@"CFBundleVersion"];
//    params[@"version"] = softversion;
//    
//    [params setValue:[[SADateFormatter sharedFormatter] getCurrentTimeStamp] forKey:@"processTime"];
//    [params setValue:[[SystemServices sharedServices] imei] forKey:@"imei"];
//}


@end
