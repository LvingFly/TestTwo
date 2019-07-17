//
//  CSBLInfoOneItemTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@interface CSBLInfoOneItemTableViewCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSIndexPath   *indexPath;


@property(nonatomic, strong)UILabel         *titleLabel;
@property(nonatomic, strong)UILabel         *contentLabel;

-(void)changeValueTextColor:(NSString *)colorString;

@end
