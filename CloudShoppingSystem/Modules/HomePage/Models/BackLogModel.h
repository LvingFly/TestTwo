//
//  BackLogModel.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/10.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SAATCModel.h"

@interface BackLogModel : SAATCModel
@property (nonatomic, strong) NSString *logId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *pictureUrl;
@property (nonatomic, strong) NSDictionary *contract;

@end
