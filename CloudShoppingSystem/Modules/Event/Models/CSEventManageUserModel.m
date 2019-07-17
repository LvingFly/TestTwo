//
//  CSEventManageUserModel.m
//  CloudShoppingSystem
//
//  Created by Living on 2017/7/13.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventManageUserModel.h"

@implementation CSEventManageUserModel
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.username = [dictionary validValueForKey:@"username"];
        self.userId = [dictionary validValueForKey:@"id"];
        self.nickname = [dictionary validValueForKey:@"nickname"];
    }
    return self;
}

@end
