//
//  CSInvestRecordTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSInvestRecordTableViewCell.h"

@interface CSInvestRecordTableViewCell ()

@property(nonatomic, strong)UIImageView      *backLogImageView;     //待办事项图片


@end

@implementation CSInvestRecordTableViewCell

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
    [self.contentView addSubview:self.backLogImageView];
    [self.contentView addSubview:self.backLogTitleLabel];
    [self.contentView addSubview:self.backLogDateLabel];
    
    [self.backLogImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(17 * SA_SCREEN_SCALE);
        make.bottom.mas_equalTo(self.contentView).offset(-17 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(53 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(88 * SA_SCREEN_SCALE);
    }];
    
    [self.backLogTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backLogImageView.mas_right).offset(10 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(self.backLogImageView);
        make.width.mas_equalTo(200 * SA_SCREEN_SCALE);
    }];
    
    [self.backLogDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backLogTitleLabel);
        make.bottom.mas_equalTo(self.backLogImageView);
    }];
}

+(NSString *)cellIdentifier
{
    return @"CSInvestRecordTableViewCellId";
}

#pragma --mark 懒加载
-(UIImageView *)backLogImageView
{
    if (!_backLogImageView) {
        _backLogImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"banner1"]];
            imageView.layer.cornerRadius = 2 * SA_SCREEN_SCALE;
            imageView.clipsToBounds = YES;
            imageView;
        });
    }
    return _backLogImageView;
}

-(UILabel *)backLogTitleLabel
{
    if (!_backLogTitleLabel) {
        _backLogTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"xxx商户招商记录" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _backLogTitleLabel;
}

-(UILabel *)backLogDateLabel
{
    if (!_backLogDateLabel) {
        _backLogDateLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"上报时间：2017年4月18日" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _backLogDateLabel;
}

@end
