//
//  BackLogModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/10.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "BackLogModel.h"

@implementation BackLogModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.logId = [dictionary validValueForKey:@"id"];
        self.type = [dictionary validValueForKey:@"type"];
        self.name = [dictionary validValueForKey:@"name"];
        self.addtime = [dictionary validValueForKey:@"addtime"];
        self.pictureUrl = [dictionary validValueForKey:@"picture"];
//        self.contract = [dictionary validValueForKey:@"contract"];
    }
    return self;
    
}

@end
