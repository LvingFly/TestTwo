//
//  CSPollingNormalTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSPollingNormalTableViewCell.h"

@interface CSPollingNormalTableViewCell ()

@property(nonatomic, strong)UILabel         *titleLabel;

@end

@implementation CSPollingNormalTableViewCell

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
    [self.contentView addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

+(NSString *)cellIdentifier
{
    return @"CSBLInfoOneItemTableViewCellId";
}

+(CGFloat)cellHeight
{
    return 44 * SA_SCREEN_SCALE;
}

-(void)changeValueTextColor:(NSString *)colorString
{
    [self.contentLabel setTextColor:[UIColor colorWithHexString:colorString]];
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
            UILabel *label = [SAControlFactory createLabel:@"事件编码" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"2017-04-18 16:00" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _contentLabel;
}


@end
