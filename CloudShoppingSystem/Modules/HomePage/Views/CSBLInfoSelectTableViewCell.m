//
//  CSBLInfoSelectTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//有button选择 弹框页面选项的cell
#import "CSBLInfoSelectTableViewCell.h"

@interface CSBLInfoSelectTableViewCell ()

@property(nonatomic, strong)UILabel         *titleLabel;
//@property(nonatomic, strong)UIButton        *selectButton;

@end

@implementation CSBLInfoSelectTableViewCell

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
//    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.value1Label];

    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(70*SA_SCREEN_SCALE);
    }];
    
    
    [self.value1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5 * SA_SCREEN_SCALE);
        //        make.right.mas_equalTo(self.contentView.mas_right).offset(-30 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
        
    }];
    
    
//    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.mas_equalTo(160 * SA_SCREEN_SCALE);
////        make.right.mas_equalTo(self.contentView.mas_right).offset(-30 * SA_SCREEN_SCALE);
//        make.centerX.mas_equalTo(self);
//        make.height.top.mas_equalTo(self.contentView);
//    }];
}

+(NSString *)cellIdentifier
{
    return @"CSBLInfoSelectTableViewCellId";
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
            UILabel *label = [SAControlFactory createLabel:@"提交人" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UILabel *)value1Label
{
    if (!_value1Label) {
        _value1Label = ({
            UILabel *label = [SAControlFactory createLabel:@"2017-04-18 16:00" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _value1Label;
}


//-(UIButton *)selectButton
//{
//    if (!_selectButton) {
//        _selectButton = ({
//            UIButton *button = [[UIButton alloc]init];
//            [button setTitleColor:SA_Color_HexString(0x46a0f3, 1) forState:UIControlStateNormal];
//            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
//            [button setTitle:@"请点击选择" forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(selectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//            button;
//        });
//    }
//    return _selectButton;
//}

@end