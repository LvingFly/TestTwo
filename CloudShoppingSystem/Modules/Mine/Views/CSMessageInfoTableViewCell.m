//
//  CSMessageInfoTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMessageInfoTableViewCell.h"

@interface CSMessageInfoTableViewCell ()

@property(nonatomic, strong)UILabel     *infoTitleLabel;        //标题
@property(nonatomic, strong)UILabel     *infoContentLabel;      //内容

@end

@implementation CSMessageInfoTableViewCell

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
    [self.contentView addSubview:self.infoTitleLabel];
    [self.contentView addSubview:self.infoContentLabel];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = SA_Color_HexString(0xf2f2f2, 1);
    [self.contentView addSubview:lineView];
    [self.infoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.infoContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1 * SA_SCREEN_SCALE);
    }];
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (_titleString) {
        [self.infoTitleLabel setText:_titleString];
    }
}

+(CGFloat)cellHeight
{
    return 46 * SA_SCREEN_SCALE;
}

+(NSString *)cellIdentifier
{
    return @"CSMessageInfoTableViewCellId";
}

#pragma --mark 懒加载
-(UILabel *)infoTitleLabel
{
    if (!_infoTitleLabel) {
        _infoTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"事件名称：" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _infoTitleLabel;
}

-(UILabel *)infoContentLabel
{
    if (!_infoContentLabel) {
        _infoContentLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"xxxxxxxx" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _infoContentLabel;
}

@end
