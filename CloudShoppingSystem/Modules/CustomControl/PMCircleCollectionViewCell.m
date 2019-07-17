//
//  PMCircleCollectionViewCell.m
//  PoMo
//
//  Created by dengyuchi on 2016/11/16.
//  Copyright © 2016年 dengyuchi. All rights reserved.
//

#import "PMCircleCollectionViewCell.h"

@implementation PMCircleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setupSubviews {
    
}

@end
