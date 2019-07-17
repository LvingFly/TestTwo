//
//  NSString+Hash.h
//  winCRM
//
//  Created by Cai Lei on 12/26/12.
//  Copyright (c) 2012 com.cailei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)MD5Hash;

@end

@interface NSString (UUID)

+(NSString *)standardUUIDString;

+(NSString *)UUIDString;

- (NSString *)replaceUnicode;



@end

@interface NSString(Ext)
+ (NSString *)stringWithObject:(id)obj;
+ (NSString *)string:(NSString *)str withStringEncoding:(NSStringEncoding)stringEncoding;

- (NSString *)stringWithTrimWhiteSpcace;

@end


@interface NSString (MSCEmpty)

- (BOOL)isNonEmpty;

/**
 *  把nil转化成@""
 *
 *  @return 
 */
+ (NSString *)nilToEmpty:(NSString *)str;

@end

@interface NSString (MSSize)

+ (CGSize)sizeForString:(NSString *)string constrainedSize:(CGSize)constrainedSize font:(UIFont *)font;

@end

