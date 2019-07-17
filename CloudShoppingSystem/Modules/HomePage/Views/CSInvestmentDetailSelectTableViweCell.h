//
//  CSInvestmentDetailSelectTableViweCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
/**
 带有选择弹框的cell
 */
#import "SABaseTableViewCell.h"

@protocol CSInvestmentDetailSelectTableViweCellDelegate <NSObject>

-(void)selectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CSInvestmentDetailSelectTableViweCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSIndexPath   *indexPath;
@property(nonatomic, weak)id<CSInvestmentDetailSelectTableViweCellDelegate>delegate;

@end
