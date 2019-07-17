
//
//  CSDataReviewHeaderView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/6.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSDataReviewHeaderView.h"

@interface CSDataReviewHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *TrafficInfoBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleSituationBtn;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeRentBtn;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConst;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsContainerViewHeightConst;


@end


@implementation CSDataReviewHeaderView



- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CSDataReviewHeaderView" owner:self options:nil] firstObject];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.topViewHeightConst.constant = 180 * SA_SCREEN_SCALE;
    self.btnsContainerViewHeightConst.constant = 220 * SA_SCREEN_SCALE;
    [self.TrafficInfoBtn addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleSituationBtn addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [self.vipBtn addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [self.storeRentBtn addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
    [self.chargeBtn addTarget:self action:@selector(action_button:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)action_button:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(webButtonClicked:)]) {
        [self.delegate webButtonClicked:sender];
    }
}



@end
