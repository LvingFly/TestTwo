
//
//  CSChatListItem.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSChatListItem.h"

@implementation CSChatListItem

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.head = [dictionary validValueForKey:@"head"];
        self.userId = [dictionary validValueForKey:@"id"];
        self.mangeCode = [dictionary validValueForKey:@"manage_code"];
        self.manageName = [dictionary validValueForKey:@"manage_name"];
        self.nickName = [dictionary validValueForKey:@"nickname"];
        
    }
    return self;
}

@end
