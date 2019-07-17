//
//  GDWSFamiliarBrandModel.h
//  Mall_GDWS
//
//  Created by dengyuchi on 16/6/29.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "SABaseModel.h"

@interface GDWSFamiliarBrandModel : SABaseModel

@property(nonatomic,strong)NSMutableArray *familiarBrandsListArr;
@property(nonatomic,strong)NSMutableArray *selectListArr;

@property(nonatomic, strong)NSError *error;
@property(nonatomic)BOOL succeed;
@property(nonatomic)BOOL hasLoadAll;
@property(nonatomic)NSInteger currrentCount;//记录当前数量

-(void)getBrandListWithCount:(NSInteger)count;


@end
