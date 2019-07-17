//
//  CSEventManageModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/11.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventManageModel.h"

@implementation CSEventManageModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.manageName = [dictionary validValueForKey:@"cname"];
        self.manageCode = [dictionary validValueForKey:@"code"];
    }
    return self;
}

@end
