//
//  CSMultifunctionTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@protocol CSMultifunctionTableViewCellDelegate <NSObject>

/**
 选择的功能
 @param index 0待办事项 1数据查看  2招商记录
 */
-(void)selectFunctionAtIndex:(NSInteger)index;

@end

@interface CSMultifunctionTableViewCell : SABaseTableViewCell

@property(nonatomic, weak)id<CSMultifunctionTableViewCellDelegate>delegate;

@end
