//
//  CSBackLogDetailMedModel.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/12.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBackLogDetailMedModel.h"

@implementation CSBackLogDetailMedModel
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.addtime = [dictionary validValueForKey:@"addtime"];
        self.deal_user = [dictionary validValueForKey:@"deal_user"];
        self.lastId = [dictionary validValueForKey:@"id"];
        self.is_continue = [dictionary validValueForKey:@"is_continue"];
        self.text = [dictionary validValueForKey:@"text"];
        self.type = [dictionary validValueForKey:@"type"];
    }
    return self;
}
@end
