//
//  CSEventFunctionFooterView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/28.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventFunctionFooterView.h"

@interface CSEventFunctionFooterView ()
@property (weak, nonatomic) IBOutlet UIButton *inputBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation CSEventFunctionFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = SA_Color_RgbaValue(242, 242, 242, 1);
        [self initSubView];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    
    self.inputBtn.layer.cornerRadius = 2.0f;
    self.inputBtn.layer.masksToBounds = YES;
    
    
    self.inputBtn.backgroundColor = SA_Color_RgbaValue(215, 215, 215, 1);
    
    self.heightConstraint.constant = 35*SA_SCREEN_SCALE;
    self.widthConstraint.constant = 250*SA_SCREEN_SCALE;
    
    self.inputBtn.backgroundColor = SA_Color_RgbaValue(52, 213, 105, 1);
    
}

- (void)initSubView {
    [self.inputBtn addTarget:self action:@selector(action_inputBtn:) forControlEvents:UIControlEventTouchUpInside];
}



- (IBAction)action_inputBtn:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(action_footViewBtn)]) {
        [self.delegate action_footViewBtn];
    }
}

@end
