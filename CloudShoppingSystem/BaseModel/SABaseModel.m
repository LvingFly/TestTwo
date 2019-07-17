//
//  SABaseModel.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/6.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseModel.h"

@implementation SABaseModel

- (void)dealloc
{
    [self cancel];
}

-(void)cancel
{
    if (self.dataTask != nil) {
        [self.dataTask cancel];
    }
}

@end
