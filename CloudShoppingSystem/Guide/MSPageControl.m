//
//  MSPageControl.m
//  MinShengOK
//
//  Created by 飞光普 on 15/7/15.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "MSPageControl.h"

@interface MSPageControl()
{
    NSMutableArray* dotViews;
}

@end

@implementation MSPageControl

-(id)initWithFrameAndPageNumber:(CGRect)frame pageNumber:(NSInteger)pageNumber
{
    CGFloat dotWidth = 0;
    CGFloat dotHeight = 0;
    CGFloat dotSpace = 0;
    
    if (IS_IPHONE_6PLUS_SCREEN) {
        dotWidth = 11;
        dotHeight = dotWidth;
        dotSpace = 12;
    } else {
        dotWidth = 8;
        dotHeight = dotWidth;
        dotSpace = 9;
    }
    
    frame = CGRectMake(0, 0, dotWidth * pageNumber + dotSpace * (pageNumber - 1), dotHeight);
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        dotViews = [[NSMutableArray alloc]init];
        self.pageNumber = pageNumber;
        
        for (int i = 0; i < pageNumber; i++) {
            UIButton* dotBtn = [[UIButton alloc]init];
            dotBtn.backgroundColor = [UIColor whiteColor];
            
            dotBtn.width = dotWidth;
            dotBtn.height = dotHeight;
            dotBtn.layer.masksToBounds = YES;
            dotBtn.layer.cornerRadius = dotWidth / 2;
            dotBtn.top = 0;
            dotBtn.left = i * dotWidth + i * dotSpace;
            dotBtn.tag = i;
            [dotBtn addTarget:self action:@selector(dotBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:dotBtn];
            [dotViews addObject:dotBtn];
        }
        
        self.currentPage = 0;
    }
    
    return self;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    for (int i = 0; i < dotViews.count; i++) {
        UIButton* button = [dotViews objectAtIndex:i];
        
        if (currentPage == i) {
            button.alpha = 1.0f;
        } else {
            button.alpha = 0.2f;
        }
    }
}

-(void)dotBtnClicked:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(onPageDotClicked:)]) {
        UIButton* button = (UIButton*)sender;
        [self.delegate onPageDotClicked:button.tag];
    }
}

@end
