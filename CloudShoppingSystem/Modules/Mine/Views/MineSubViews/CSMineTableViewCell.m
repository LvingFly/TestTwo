//
//  CSMineTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMineTableViewCell.h"

@interface CSMineTableViewCell ()

@property(nonatomic, strong)UIImageView     *itemImageView;
@property(nonatomic, strong)UILabel         *itemTitleLabel;
@property(nonatomic, strong)UILabel         *itemSubTitleLabel; //目前就部门那里需要此label

@end

@implementation CSMineTableViewCell

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
    [self.contentView addSubview:self.itemImageView];
    [self.contentView addSubview:self.itemTitleLabel];
    [self.contentView addSubview:self.itemSubTitleLabel];
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.itemTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.itemImageView.mas_right).offset(10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.itemSubTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.itemTitleLabel.mas_right).offset(70 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

-(void)setTitle:(NSString *)title imageString:(NSString *)imageString
{
    [self.itemTitleLabel setText:title];
    [self.itemImageView setImage:[UIImage imageNamed:imageString]];
}

-(void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    if (_subTitle) {
        self.itemSubTitleLabel.hidden = NO;
        [self.itemSubTitleLabel setText:_subTitle];
    }
}

+(CGFloat)cellHeight
{
    return 50 * SA_SCREEN_SCALE;
}

+(NSString *)cellIdentifier
{
    return @"CSMineTableViewCellId";
}

#pragma --mark 懒加载
-(UIImageView *)itemImageView
{
    if (!_itemImageView) {
        _itemImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@""]];
            imageView;
        });
    }
    return _itemImageView;
}

-(UILabel *)itemTitleLabel
{
    if (!_itemTitleLabel) {
        _itemTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"销售部" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _itemTitleLabel;
}

-(UILabel *)itemSubTitleLabel
{
    if (!_itemSubTitleLabel) {
        _itemSubTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"销售专员" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label.hidden = YES;
            label;
        });
    }
    return _itemSubTitleLabel;
}

@end
