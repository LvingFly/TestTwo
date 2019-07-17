//
//  GDWSShopExpModel.h
//  Mall_GDWS
//
//  Created by dengyuchi on 16/6/29.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "SABaseModel.h"

@interface GDWSShopExpModel : SABaseModel

@property(nonatomic,strong)NSMutableArray *shopExListArr;
@property(nonatomic,strong)NSMutableArray *selectListArr;

@property(nonatomic, strong)NSError *error;
@property(nonatomic)BOOL succeed;

-(void)getShopExpList:(NSString *)count;

@end
