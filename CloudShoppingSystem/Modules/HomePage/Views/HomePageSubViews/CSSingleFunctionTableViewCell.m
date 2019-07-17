//
//  CSSingleFunctionTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSingleFunctionTableViewCell.h"

@interface CSSingleFunctionTableViewCell ()

@property(nonatomic, strong)UIImageView     *logoImageView;
@property(nonatomic, strong)UILabel         *titleLabel;

@end

@implementation CSSingleFunctionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 12 * SA_SCREEN_SCALE;
    [self.contentView addSubview:bgView];
    
    [bgView addSubview:self.logoImageView];
    [bgView addSubview:self.titleLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.contentView).offset(-13 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(102 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(bgView);
        make.width.height.mas_equalTo(86 * SA_SCREEN_SCALE);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImageView.mas_right).offset(30 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(bgView);
    }];
}

+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"CSSingleFunctionTableViewCellId";
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    if (_title) {
        [self.titleLabel setText:_title];
    }
}

#pragma --mark 懒加载
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"monitoring"]];
            imageView;
        });
    }
    return _logoImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"巡查监控" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

@end
