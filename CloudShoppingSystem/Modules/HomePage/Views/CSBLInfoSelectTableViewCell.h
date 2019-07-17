//
//  CSBLInfoSelectTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@protocol CSBLInfoSelectTableViewCellDelegate <NSObject>

-(void)selectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CSBLInfoSelectTableViewCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSIndexPath   *indexPath;
@property(nonatomic, weak)id<CSBLInfoSelectTableViewCellDelegate>delegate;
@property(nonatomic, strong)UILabel     *value1Label;//提交人名字

@end
