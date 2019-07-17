//
//  GDWSFamiliarBrandModel.m
//  Mall_GDWS
//
//  Created by dengyuchi on 16/6/29.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSFamiliarBrandModel.h"
#import "GDWSShopExpItem.h"

@implementation GDWSFamiliarBrandModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.familiarBrandsListArr = [[NSMutableArray alloc]init];
        self.selectListArr = [[NSMutableArray alloc]init];
        self.currrentCount = 0;
        self.hasLoadAll = NO;
    }
    return self;
}

-(void)getBrandListWithCount:(NSInteger)count
{
    [self postFamiliarBrandListWithPage:self.currrentCount count:count];
   
}

-(void)postFamiliarBrandListWithPage:(NSInteger)startIndex count:(NSInteger)count
{
    _succeed = NO;
    __weak typeof(self) weakSelf = self;
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    
    self.dataTask = [networkManager postFamiliarBrandWithUid:[SAUserInforManager shareManager].userID startIndex:[NSString stringWithFormat:@"%ld",startIndex] count:[NSString stringWithFormat:@"%ld",count] callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            NSLog(@"familiarbrandList%@",dicData);
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE)
            {
                if(weakSelf.familiarBrandsListArr.count >0)
                {
                    [weakSelf.familiarBrandsListArr removeAllObjects];
                }
                
                if (weakSelf.selectListArr.count > 0) {
                    [weakSelf.selectListArr removeAllObjects];
                }
        
                //加载品牌列表
                NSDictionary *expDataDic = [dicData validValueForKey:@"data"];
                NSArray *dataArr = [expDataDic validValueForKey:@"list"];
                NSInteger totalCount = [[expDataDic validValueForKey:@"total"] integerValue];
                if (dataArr && [dataArr isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *exItemDic in dataArr) {
                        GDWSShopExpItem *exItem = [[GDWSShopExpItem alloc]initWithDictionary:exItemDic];
                        [weakSelf.familiarBrandsListArr addObject:exItem];
                    }
                }
                
                //加载之前选中的品牌
                NSArray *selectDataArr = [expDataDic validValueForKey:@"selected_list"];
                if (weakSelf.currrentCount == 0) {
                    if (selectDataArr && [selectDataArr isKindOfClass:[NSArray class]]) {
                        for (NSDictionary *expItem in selectDataArr) {
                            GDWSShopExpItem *selectItem = [[GDWSShopExpItem alloc]initWithDictionary:expItem];
                            [weakSelf.selectListArr addObject:selectItem];
                        }
                    }
                }
                
                weakSelf.currrentCount += count;
              //  weakSelf.currentPage += 1;
                if (weakSelf.currrentCount >= totalCount) {
                    weakSelf.hasLoadAll = YES;
                }
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
