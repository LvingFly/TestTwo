//
//  CSBLHistoryTableViewCell.h
//  CloudShoppingSystem
//
//  Created by Living on 2017/7/11.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

#import "CSBackLogDetailBaseModel.h"
#import "CSBackLogDetailLastModel.h"
#import "CSBackLogDetailMedModel.h"

@interface CSBLHistoryTableViewCell : SABaseTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *eventBtn;

@property (weak, nonatomic) IBOutlet UIView *topLineView;

@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

-(void)setBaseContent:(CSBackLogDetailBaseModel *)item;
-(void)setMedContent:(CSBackLogDetailMedModel *)item;

@end
