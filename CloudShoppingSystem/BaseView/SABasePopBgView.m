//
//  SAPopWindowBgView.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/4.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABasePopBgView.h"

@implementation SABasePopBgView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.6;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event] ;
    if(self.touchBlock)
    {
        _touchBlock() ;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
