//
//  CSPersonalInfoTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSPersonalInfoTableViewCell.h"

@interface CSPersonalInfoTableViewCell ()

@property(nonatomic, strong)UILabel         *titleLabel;
@property(nonatomic, strong)UILabel         *valueLabel;

@end

@implementation CSPersonalInfoTableViewCell

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
    [self.contentView addSubview:self.valueLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(2 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

+(CGFloat)cellHeight
{
    return 46 * SA_SCREEN_SCALE;
}

+(NSString *)cellIdentifier
{
    return @"CSPersonalInfoTableViewCellId";
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (_titleString) {
        [self.titleLabel setText:_titleString];
    }
}

-(void)setValueString:(NSString *)valueString
{
    _valueString = valueString;
    if (_valueString) {
        [self.valueLabel setText:_valueString];
    }
}

#pragma --mark 懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"用户名：" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#333333"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"Tommy" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#727272"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _valueLabel;
}

@end
