//
//  CSInvestRecordTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@interface CSInvestRecordTableViewCell : SABaseTableViewCell
@property(nonatomic, strong)UILabel          *backLogTitleLabel;    //待办事项标题
@property(nonatomic, strong)UILabel          *backLogDateLabel;     //待办事项上报时间
@end
