//
//  CSMineTableViewCell.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SABaseTableViewCell.h"

@interface CSMineTableViewCell : SABaseTableViewCell

-(void)setTitle:(NSString *)title imageString:(NSString *)imageString;

@property(nonatomic,strong)NSString *subTitle; //目前就部门那里需要此label

@end
