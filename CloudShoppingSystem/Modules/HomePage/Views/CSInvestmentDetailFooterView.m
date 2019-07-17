//
//  CSInvestmentDetailFooterView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/10.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSInvestmentDetailFooterView.h"

@interface CSInvestmentDetailFooterView ()

@property(nonatomic, strong)UIButton    *addEnclosureButton;       //添加附件
@property(nonatomic, strong)UIButton    *saveButton;               //保存

@end

@implementation CSInvestmentDetailFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
//    [self addSubview:self.addEnclosureButton];
    [self addSubview:self.saveButton];
//    [self.addEnclosureButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.top.mas_equalTo(20 * SA_SCREEN_SCALE);
////        make.height.mas_equalTo(75 * SA_SCREEN_SCALE);
//        make.height.mas_equalTo(0 * SA_SCREEN_SCALE);
//    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.width.mas_equalTo(self);
//        make.height.mas_equalTo(60 * SA_SCREEN_SCALE);
//        make.top.mas_equalTo(self.addEnclosureButton.mas_bottom).offset(20 *SA_SCREEN_SCALE);
        make.left.mas_equalTo(self).offset(0);
        make.right.mas_equalTo(self).offset(0);
        make.height.mas_equalTo(60 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(self);
    
    }];
}

#pragma  --mark 懒加载
-(UIButton *)addEnclosureButton
{
    if (!_addEnclosureButton) {
        _addEnclosureButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"点击上传附件" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"addEnclosure"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            [button sizeToFit];
            button.titleEdgeInsets = UIEdgeInsetsMake(10 * SA_SCREEN_SCALE + button.imageView.height, -button.imageView.width, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 10 * SA_SCREEN_SCALE + button.titleLabel.height, -button.titleLabel.width);
            button;
        });
    }
    return _addEnclosureButton;
}

-(UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setBackgroundColor:SA_Color_HexString(0xd7d7d7, 1) forState:UIControlStateDisabled];
            [button setBackgroundColor:SA_Color_HexString(0x34d569, 1) forState:UIControlStateNormal];
            
            [button setTitle:@"保存" forState:UIControlStateNormal];
            [button setTitle:@"保存" forState:UIControlStateDisabled];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
            button;
        });
    }
    return _saveButton;
}


@end
