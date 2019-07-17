//
//  SAConfig.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAConfig.h"

@implementation SAConfig

#pragma mark - 判断
BOOL MSIsIPhone5() {
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (screenHeight > 480.0f) {
        return YES;
    }
    return NO;
}

BOOL MSIsiOS7(){
    float currentVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (currentVersion >= 7.0) {
        return YES;
    }else {
        return NO;
    }
}

BOOL MSIsiOS8()
{
    float currentVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (currentVersion >= 8.0) {
        return YES;
    }else {
        return NO;
    }
}

BOOL MSIsArrayWithItems(id object) {
    return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

BOOL MSIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}

#pragma mark - 读取本地图片
UIImage* MSImageNamed(NSString *imageName) {
    if (MSIsIPhone5()) {
        if ([[imageName lowercaseString] hasSuffix:@".png"] ||
            [[imageName lowercaseString] hasSuffix:@".jpg"] ||
            [[imageName lowercaseString] hasSuffix:@".gif"]) {
            NSString *name = [NSString stringWithFormat:@"%@-568h@2x%@",
                              [imageName substringToIndex:(imageName.length - 4)],
                              [imageName substringFromIndex:(imageName.length - 4)]];
            UIImage *image = [UIImage imageNamed:name];
            if (image) {
                return image;
            }else {
                return [UIImage imageNamed:imageName];
            }
        }else {
            NSString *name = [NSString stringWithFormat:@"%@-568h@2x", imageName];
            UIImage *image = [UIImage imageNamed:name];
            if (image) {
                return image;
            }else {
                return [UIImage imageNamed:imageName];
            }
        }
    }
    return [UIImage imageNamed:imageName];
}

@end


