//
//  SABaseModel.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/6.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ERefresh, //下拉刷新
    ELoadMore, //上拉加载
}SARefreshType;

@interface SABaseModel : NSObject

@property(nonatomic, readwrite)SARefreshType refreshType;
@property(nonatomic, strong)NSURLSessionDataTask* dataTask;

-(void)cancel;

//当前页
@property(nonatomic)NSInteger currentPage;
//每一页所包含的条数，在子类的init函数中初始化
@property(nonatomic)NSInteger pageCount;

@end