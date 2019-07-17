//
//  CSBLInfoNormalTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@interface CSBLInfoNormalTableViewCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSIndexPath   *indexPath;

@property(nonatomic, strong)UILabel     *value1Label;//事件名称
@property(nonatomic, strong)UILabel     *value2Label;//事件类型


-(void)setTitle1String:(NSString *)title1 title2String:(NSString *)title2;



@end
