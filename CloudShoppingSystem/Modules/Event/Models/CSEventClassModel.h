//
//  CSEventClassModel.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SAATCModel.h"

@interface CSEventClassModel : SAATCModel

@property (nonatomic, strong) NSString *manageCode;//部门编号
@property (nonatomic, strong) NSString *manageName;//部门名称
@property (nonatomic, strong) NSString *name;//事件名称
@property (nonatomic, strong) NSString *classId;//事件ID

@end
