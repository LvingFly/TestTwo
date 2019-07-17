//
//  CSEventClassModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventClassModel.h"

@implementation CSEventClassModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.manageName = [dictionary validValueForKey:@"manage_name"];
        self.manageCode = [dictionary validValueForKey:@"manage_code"];
        self.name = [dictionary validValueForKey:@"name"];
        self.classId = [dictionary validValueForKey:@"id"];
    }
    return self;
}


@end
