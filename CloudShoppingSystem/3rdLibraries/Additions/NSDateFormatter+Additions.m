//
// Created by chenxu on 13-12-23.
// Copyright (c) 2013 winchannel. All rights reserved.


#import "NSDateFormatter+Additions.h"


@implementation NSDateFormatter(Additions)
+ (NSDateFormatter *)formatYearMonthDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    return dateFormatter;
}

@end