//
//  CSEventFunctionTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/27.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@interface CSEventFunctionTableViewCell : SABaseTableViewCell


@property(nonatomic, strong)UILabel          *eventTitleLabel;    //事件标题
@property(nonatomic, strong)UILabel          *backLogPriorityLabel; //请选择文本
@property(nonatomic, strong)UILabel          *contentLabel;    //事件内容


@end
