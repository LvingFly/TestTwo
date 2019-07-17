//
//  SAControlFactory.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAControlFactory.h"

@implementation SAControlFactory

+(UILabel*)createLabel:(NSString*)text backgroundColor:(UIColor*)backgroundColor font:(UIFont*)font textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    UILabel* label = [[UILabel alloc]init];
    label.backgroundColor = backgroundColor;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.lineBreakMode = lineBreakMode;
    label.text = text;
    [label sizeToFit];
    
    return label;
}

+(UIImageView*)createImageView:(UIColor*)backgroundColor width:(CGFloat)width height:(CGFloat)height
{
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    imageView.backgroundColor = backgroundColor;
    
    return imageView;
}

+(UIView*)createView:(UIColor*)backgroundColor width:(CGFloat)width height:(CGFloat)height;
{
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = backgroundColor;
    
    return view;
}

+(UIButton *)createButton:(UIColor*)backgroundColor titleColor:(UIColor *)titleColor labelFont:(NSInteger)labelFont titleString:(NSString *)titleString {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:titleString forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    [button setBackgroundColor:backgroundColor forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor forState:UIControlStateSelected];
    return button;
}

@end
