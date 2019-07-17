//
//  GDWSShopExpModel.m
//  Mall_GDWS
//
//  Created by dengyuchi on 16/6/29.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSShopExpModel.h"
#import "GDWSShopExpItem.h"

@implementation GDWSShopExpModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSString *count = @"14";
        _shopExListArr = [NSMutableArray array];
        _selectListArr = [NSMutableArray array];
        [self getShopExpList:count];
    }
    return self;
}

-(void)dealloc
{
    [self.dataTask cancel];
}

-(void)getShopExpList:(NSString *)count
{
    _succeed = NO;
    __weak typeof(self) weakSelf = self;
    
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    self.dataTask = [networkManager postShopExListWithUid:[SAUserInforManager shareManager].userID page:@"1" count:count callBack:^(id resp, NSError *error) {
        if (!error) {
            if(weakSelf.shopExListArr.count >0)
            {
                [weakSelf.shopExListArr removeAllObjects];
            }
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            NSLog(@"shopExpList%@",dicData);
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE)
            {
                NSDictionary *expDataDic = [dicData validValueForKey:@"data"];
                NSArray *dataArr = [expDataDic validValueForKey:@"list"];
                if (dataArr && [dataArr isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *exItemDic in dataArr) {
                        GDWSShopExpItem *exItem = [[GDWSShopExpItem alloc]initWithDictionary:exItemDic];
                        [weakSelf.shopExListArr addObject:exItem];
                    }
                }
                
                //加载之前选中的品牌
                NSArray *selectDataArr = [expDataDic validValueForKey:@"selected_list"];
              //  if (weakSelf.currrentCount == 0) {
                    if (selectDataArr && [selectDataArr isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *expItem in selectDataArr) {
                            GDWSShopExpItem *selectItem = [[GDWSShopExpItem alloc]initWithDictionary:expItem];
                            [weakSelf.selectListArr addObject:selectItem];
                        }
                    }
              //  }
                
                weakSelf.succeed = YES;
                
            }
            else
            {
                NSString *errorMessage = @"数据加载失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                weakSelf.error = [NSError errorWithDomain:@"unknown"
                                                     code:-1
                                                 userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
            }
        }
        else
        {
            NSString *errorMessage = @"数据加载失败";
            NSInteger errorCode = -1;
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
                errorCode = [error code];

            }
            weakSelf.error = [NSError errorWithDomain:@"unknown"
                                                 code:errorCode
                                             userInfo:@{NSLocalizedDescriptionKey:errorMessage}];
        }
    }];
}

@end
