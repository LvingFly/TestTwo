
//
//  CSBackLogDetailBaseModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/12.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBackLogDetailBaseModel.h"

@implementation CSBackLogDetailBaseModel


- (id)initWithDictionary:(NSDictionary *)dictionary  {
    self = [super initWithDictionary:dictionary];
    if (self) {
       
        self.add_uid = [dictionary validValueForKey:@"add_uid"];
        self.addtime = [dictionary validValueForKey:@"addtime"];
        self.classify = [dictionary validValueForKey:@"classify"];
        self.code = [dictionary validValueForKey:@"code"];
        self.userId = [dictionary validValueForKey:@"id"];
        self.location = [dictionary validValueForKey:@"location"];
        self.manage = [dictionary validValueForKey:@"manage"];
        self.name = [dictionary validValueForKey:@"name"];
        self.status = [dictionary validValueForKey:@"status"];
        self.type = [dictionary validValueForKey:@"type"];
        self.user = [dictionary validValueForKey:@"user"];
    }
    return self;
}

@end
