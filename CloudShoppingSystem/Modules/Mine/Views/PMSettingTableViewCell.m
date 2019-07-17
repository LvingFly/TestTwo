//
//  PMSettingTableViewCell.m
//  PoMo
//
//  Created by dengyuchi on 2016/11/30.
//  Copyright © 2016年 dengyuchi. All rights reserved.
//

#import "PMSettingTableViewCell.h"

@interface PMSettingTableViewCell ()

@property(nonatomic, strong)UILabel     *titleLabel;
//@property(nonatomic, strong)UISwitch    *openNotificationSwich;//是否打开通知
//@property(nonatomic, strong)UILabel     *cacheNumberLabel;     //缓存大小

@end

@implementation PMSettingTableViewCell

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
//    [self.contentView addSubview:self.cacheNumberLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
//    [self.cacheNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.contentView).offset(-20 * SA_SCREEN_SCALE);
//        make.centerY.mas_equalTo(self.contentView);
//    }];
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    if (_titleString) {
        [self.titleLabel setText:_titleString];
    }
}

//-(void)setCacheNumber:(NSString *)cacheNumber
//{
//    _cacheNumber = cacheNumber;
//    if(_cacheNumber)
//    {
//        [self.cacheNumberLabel setText:_cacheNumber];
//    }
//}

+(CGFloat)cellHeight
{
    return 50 * SA_SCREEN_SCALE;
}

+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"PMSettingTableViewCell";
}

#pragma --mark 懒加载
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"邀请好友使用" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#333333"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

//-(UILabel *)cacheNumberLabel
//{
//    if (!_cacheNumberLabel) {
//        _cacheNumberLabel = ({
//            UILabel *label = [SAControlFactory createLabel:@"0.00M" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#ff2d55"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
//            label.hidden = YES;
//            label;
//        });
//    }
//    return _cacheNumberLabel;
//}

@end
