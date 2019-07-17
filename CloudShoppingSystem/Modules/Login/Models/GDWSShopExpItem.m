//
//  GDWSShopExpItem.m
//  Mall_GDWS
//
//  Created by dengyuchi on 16/6/28.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSShopExpItem.h"

@implementation GDWSShopExpItem

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.exId = [dictionary validValueForKey:@"id"];
        self.exIcon = [dictionary validValueForKey:@"icon"];
        self.exName = [dictionary validValueForKey:@"name"];
    }
    return self;
}

@end
