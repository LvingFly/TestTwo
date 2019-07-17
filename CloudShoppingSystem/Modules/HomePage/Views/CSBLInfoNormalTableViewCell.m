//
//  CSBLInfoNormalTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//一般展示信息的Cell，展示了两个信息
#import "CSBLInfoNormalTableViewCell.h"

@interface CSBLInfoNormalTableViewCell ()

@property(nonatomic, strong)UILabel     *title1Label;           //有两个标题，这是前面一个
@property(nonatomic, strong)UILabel     *title2Label;

@end

@implementation CSBLInfoNormalTableViewCell

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
    [self.contentView addSubview:self.title1Label];
    [self.contentView addSubview:self.value1Label];
    [self.contentView addSubview:self.title2Label];
    [self.contentView addSubview:self.value2Label];
    
    [self.title1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(70*SA_SCREEN_SCALE);
    }];
    
    [self.value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.title1Label.mas_right).offset(5 * SA_SCREEN_SCALE);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-30 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.title2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.value2Label.mas_left).offset(-8 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_greaterThanOrEqualTo(self.value1Label.mas_right).offset(5 * SA_SCREEN_SCALE);
    }];
    
    [self.value2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.value2Label.width);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-8 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

+(NSString *)cellIdentifier
{
    return @"CSBLInfoNormalTableViewCellId";
}

+(CGFloat)cellHeight
{
    return 44 * SA_SCREEN_SCALE;
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (_titleString) {
    }
}

-(void)setTitle1String:(NSString *)title1 title2String:(NSString *)title2
{
    [self.title1Label setText:title1];
    [self.title2Label setText:title2];
}

#pragma --mark 懒加载
-(UILabel *)title1Label
{
    if (!_title1Label) {
        _title1Label = ({
            UILabel *label = [SAControlFactory createLabel:@"事件名称" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _title1Label;
}

-(UILabel *)value1Label
{
    if (!_value1Label) {
        _value1Label = ({
            UILabel *label = [SAControlFactory createLabel:@"2017-04-18 16:00" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _value1Label;
}

-(UILabel *)title2Label
{
    if (!_title2Label) {
        _title2Label = ({
            UILabel *label = [SAControlFactory createLabel:@"事件分类" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _title2Label;
}

-(UILabel *)value2Label
{
    if (!_value2Label) {
        _value2Label = ({
            UILabel *label = [SAControlFactory createLabel:@"一般事件" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _value2Label;
}

@end
