//
//  CSMessageTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMessageTableViewCell.h"

@interface CSMessageTableViewCell ()

@property(nonatomic, strong)UILabel         *messageTitleLabel;     //消息标题
@property(nonatomic, strong)UILabel         *messageDatelabel;      //日期

@end

@implementation CSMessageTableViewCell


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
    [self.contentView addSubview:self.messageTitleLabel];
    [self.contentView addSubview:self.messageDatelabel];
    [self.messageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.messageDatelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.messageTitleLabel.mas_right).offset(30 * SA_SCREEN_SCALE);
    }];
}

+(CGFloat)cellHeight
{
    return 46 * SA_SCREEN_SCALE;
}

+(NSString *)cellIdentifier
{
    return @"CSMessageTableViewCellId";
}

#pragma --mark 懒加载
-(UILabel *)messageTitleLabel
{
    if (!_messageTitleLabel) {
        _messageTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"张山所走的巡检地点是否按照要求巡检正确正确" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _messageTitleLabel;
}

-(UILabel *)messageDatelabel
{
    if (!_messageDatelabel) {
        _messageDatelabel = ({
            UILabel *label = [SAControlFactory createLabel:@"2017-06-16" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(13) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _messageDatelabel;
}

@end
