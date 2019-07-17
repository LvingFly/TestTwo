//
//  CSMessageScheduleTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMessageScheduleTableViewCell.h"

@interface CSMessageScheduleTableViewCell ()

@property(nonatomic, strong)UIView      *signView;              //标识进度完成
@property(nonatomic, strong)UIView      *lineView;
@property(nonatomic, strong)UILabel     *scheduleTitleLabel;
@property(nonatomic, strong)UILabel     *scheduleDateLabel;

@end

@implementation CSMessageScheduleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview:self.signView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.scheduleTitleLabel];
    [self.contentView addSubview:self.scheduleDateLabel];
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.width.height.mas_equalTo(16 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(0);
    }];
    
    [self.scheduleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.signView.mas_right).offset(2 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(0);
    }];
    
    [self.scheduleDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.scheduleTitleLabel);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.signView);
        make.top.mas_equalTo(self.signView.mas_bottom);
        make.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(1 * SA_SCREEN_SCALE);
    }];
}

+(CGFloat)cellHeight
{
    return 56 * SA_SCREEN_SCALE;
}

+(NSString *)cellIdentifier
{
    return @"CSMessageScheduleTableViewCellId";
}

-(void)setLineViewHidden:(BOOL)hidden
{
    self.lineView.hidden = hidden;
}

#pragma --mark 懒加载
-(UIView *)signView
{
    if (!_signView) {
        _signView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#46a0fc"];
            view.layer.cornerRadius = 8 * SA_SCREEN_SCALE;
            view;
        });
    }
    return _signView;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#d7d7d7"];
            view;
        });
    }
    return _lineView;
}

-(UILabel *)scheduleTitleLabel
{
    if (!_scheduleTitleLabel) {
        _scheduleTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"进度进度进度" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x40a6fc, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _scheduleTitleLabel;
}

-(UILabel *)scheduleDateLabel
{
    if (!_scheduleDateLabel) {
        _scheduleDateLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"05-16 12:30" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x40a6fc, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _scheduleDateLabel;
}

@end
