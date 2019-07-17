//
//  NSString+Extension.m
//  winCRM
//
//  Created by Cai Lei on 12/26/12.
//  Copyright (c) 2012 com.cailei. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Hash)

- (NSString *)MD5Hash
{
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, strlen(cStr), result);
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

@end

@implementation NSString(UUID)
+(NSString *)UUIDString
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);

    // Get the string representation of CFUUID object.
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);

    CFRelease(uuidObject);

    return [uuidStr MD5Hash];
}

- (NSString *)replaceUnicode
{
    if([self rangeOfString:@"\\u"].location==NSNotFound)
        return self;

    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+ (NSString *)standardUUIDString
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);

    // Get the string representation of CFUUID object.
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject);

    CFRelease(uuidObject);

    return uuidStr;
}


@end

@implementation NSString(Ext)

+ (NSString *)stringWithObject:(id)obj
{
    if (obj)
    {
        return [NSString stringWithFormat:@"%@", obj];
    }

    return @"";
}

+ (NSString *)string:(NSString *)str withStringEncoding:(NSStringEncoding)stringEncoding;
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":",
                                                     @"@", @"&", @"=", @"+", @"$", @",", @"!",
                                                     @"'", @"(", @")", @"*", @"-", @"~", @"_", nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A",
                                                      @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21",
                                                      @"%27", @"%28", @"%29", @"%2A", @"%2D", @"%7E", @"%5F", nil];

    NSString *tempStr = [str stringByAddingPercentEscapesUsingEncoding:stringEncoding];
    if (tempStr == nil) return nil;

    NSMutableString *temp = [tempStr mutableCopy];
    NSInteger len = [escapeChars count];
    for (NSInteger i = 0; i < len; i++)
    {
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }

    NSString *outStr = [NSString stringWithString:temp];
    return outStr;
}

- (NSString *)stringWithTrimWhiteSpcace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}




@end

@implementation NSString (MSCEmpty)

- (BOOL)isNonEmpty
{
    if (self && [self isKindOfClass:[NSString class]]) {
        if (self.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

+ (NSString *)nilToEmpty:(NSString *)str;
{
    if (str == nil) {
        return @"";
    }
    return str;
}
@end

@implementation NSString (MSSize)

+ (CGSize)sizeForString:(NSString *)string constrainedSize:(CGSize)constrainedSize font:(UIFont *)font
{
    CGSize size = CGSizeMake(0, 0);
    if (MSIsiOS7())
    {
        NSDictionary *attribute = @{NSFontAttributeName: font};
        
        size = [string boundingRectWithSize:constrainedSize options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
        
    }
    
    return size;
}

@end


