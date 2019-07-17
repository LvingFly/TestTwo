//
//  CSInvestmentDetailNormalTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSInvestmentDetailNormalTableViewCell.h"

@interface CSInvestmentDetailNormalTableViewCell ()<UITextFieldDelegate>

@property(nonatomic, strong)UILabel         *titleLabel;
@property(nonatomic, strong)UITextField     *contentTextField;
@property(nonatomic, strong)UILabel         *contentLabel;

@end

@implementation CSInvestmentDetailNormalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview:self.titleLabel];
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];
    [bgView addSubview:self.contentTextField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(160 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-30 * SA_SCREEN_SCALE);
        make.height.top.mas_equalTo(self.contentView);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(bgView);
    }];
    
}

+(NSString *)cellIdentifier
{
    return @"CSInvestmentDetailNormalTableViewCellId";
}

+(CGFloat)cellHeight
{
    return 44 * SA_SCREEN_SCALE;
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (_titleString) {
        [self.titleLabel setText:_titleString];
        [self.titleLabel sizeToFit];
    }
}

#pragma --mark 懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"项目" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UITextField *)contentTextField
{
    if (!_contentTextField) {
        _contentTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(16)];
            [textField setTextColor:[UIColor colorWithHexString:@"#727272"]];
            textField.backgroundColor = [UIColor clearColor];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeyDone;
            textField.placeholder = @"请填写";
            textField;
        });
    }
    return _contentTextField;
}

@end
