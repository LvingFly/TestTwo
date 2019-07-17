//
//  CSPollingSelectTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@protocol CSPollingSelectTableViewCellDelegate <NSObject>

-(void)selectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CSPollingSelectTableViewCell : SABaseTableViewCell

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, strong)NSIndexPath   *indexPath;
@property(nonatomic, strong)UIButton        *selectButton;
@property(nonatomic, weak)id<CSPollingSelectTableViewCellDelegate>delegate;

@end
