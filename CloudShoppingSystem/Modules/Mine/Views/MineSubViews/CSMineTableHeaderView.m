//
//  CSMineTableHeaderView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMineTableHeaderView.h"

@interface CSMineTableHeaderView ()

@property(nonatomic, strong)UIImageView     *bgImageView;
@property(nonatomic, strong)UIImageView     *headerImageView;
@property(nonatomic, strong)UILabel         *nickNameLabel;
@property(nonatomic, strong)UIButton        *checkInButton;         //签到

@end

@implementation CSMineTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSString *nickName = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UserName];
        self.nickNameLabel.text = nickName;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.headerImageView];
    [self.bgImageView addSubview:self.nickNameLabel];
    [self.bgImageView addSubview:self.checkInButton];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.width.mas_equalTo(self);
        make.height.mas_equalTo(168 * SA_SCREEN_SCALE);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.height.width.mas_equalTo(66 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(5 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.checkInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(56 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-2 * SA_SCREEN_SCALE);
    }];
}

#pragma --mark event clicked
//点击头像
-(void)headerImageViewClicked:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(headerImageClicked)]) {
        [self.delegate headerImageClicked];
    }
}
//点击签到按钮
-(void)checkInButtonClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(checkInClicked:)]) {
        [self.delegate checkInClicked:sender];
    }
}

#pragma --mark 懒加载
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"bgImage"]];
            imageView.userInteractionEnabled = YES;
            imageView;
        });
    }
    return _bgImageView;
}

-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"headImage"]];
            imageView.layer.cornerRadius = 33 * SA_SCREEN_SCALE;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerImageViewClicked:)];
            [imageView addGestureRecognizer:headerTap];
            imageView;
        });
    }
    return _headerImageView;
}

-(UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"Tommy" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0xffffff, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _nickNameLabel;
}

-(UIButton *)checkInButton
{
    if (!_checkInButton) {
        _checkInButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setImage:[UIImage imageNamed:@"checkIn"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateDisabled];
            [button setTitle:@"签到" forState:UIControlStateNormal];
            [button setTitle:@"已签到" forState:UIControlStateDisabled];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:SA_Color_HexString(0x46a0fc, 1) forState:UIControlStateDisabled];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
            button.layer.cornerRadius = 28 * SA_SCREEN_SCALE;
            [button addTarget:self action:@selector(checkInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.width, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.width);
            button;
        });
    }
    return _checkInButton;
}

@end
