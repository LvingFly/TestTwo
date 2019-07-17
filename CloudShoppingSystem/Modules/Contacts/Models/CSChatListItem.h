//
//  CSChatListItem.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "SAATCModel.h"

@interface CSChatListItem : SAATCModel

@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *userId;//用户id
@property (nonatomic, strong) NSString *mangeCode;//用户编号
@property (nonatomic, strong) NSString *manageName;//部门名字
@property (nonatomic, strong) NSString *nickName;//昵称

@end
