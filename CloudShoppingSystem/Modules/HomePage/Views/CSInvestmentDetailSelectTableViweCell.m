//
//  CSInvestmentDetailSelectTableViweCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSInvestmentDetailSelectTableViweCell.h"

@interface CSInvestmentDetailSelectTableViweCell ()

@property(nonatomic, strong)UILabel         *titleLabel;
@property(nonatomic, strong)UIButton        *selectButton;

@end

@implementation CSInvestmentDetailSelectTableViweCell

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
    [self.contentView addSubview:self.selectButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(160 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-30 * SA_SCREEN_SCALE);
        make.height.top.mas_equalTo(self.contentView);
    }];
}

+(NSString *)cellIdentifier
{
    return @"CSInvestmentDetailSelectTableViweCellId";
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
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25 * SA_SCREEN_SCALE);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(self.titleLabel.width);
        }];
    }
}

#pragma --mark button clicked
-(void)selectButtonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(selectItemAtIndexPath:)]) {
        [self.delegate selectItemAtIndexPath:self.indexPath];
    }
}

#pragma --mark 懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"期望起租面积(m²)" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UIButton *)selectButton
{
    if (!_selectButton) {
        _selectButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitleColor:SA_Color_HexString(0x34d569, 1) forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
            [button setTitle:@"请点击选择" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _selectButton;
}

@end
