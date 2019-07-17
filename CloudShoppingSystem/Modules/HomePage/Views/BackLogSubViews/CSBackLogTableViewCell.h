//
//  CSBackLogTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"
#import "BackLogModel.h"



@interface CSBackLogTableViewCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *logId;



-(void)initModelData:(BackLogModel *)model;

@end
