//
//  CSBackLogTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBackLogTableViewCell.h"

@interface CSBackLogTableViewCell ()

@property(nonatomic, strong)UIImageView              *backLogImageView;                   //待办事项图片
@property(nonatomic, strong)UILabel                       *backLogTitleLabel;                     //待办事项标题
@property(nonatomic, strong)UILabel                       *backLogPriorityLabel;                 //待办事项优先级
@property(nonatomic, strong)UILabel                       *backLogDateLabel;                     //待办事项上报时间
@property(nonatomic, strong)UIImageView              *backLogPriorityImageView;         //待办优先级图片

@end

@implementation CSBackLogTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initModelData:(BackLogModel *)model {
    
//    NSString*string = model.addtime;
//    string = [string substringToIndex:10];//截取掉下标7之后的字符串
    [self.backLogDateLabel setText:[NSString stringWithFormat:@"上报时间:%@",model.addtime]];
    [self.backLogTitleLabel setText:[NSString stringWithFormat:@"%@事件",model.name]];
    self.logId = model.logId;
    int typeNumber = [model.type intValue];
    switch (typeNumber) {
        case 1:
            self.backLogPriorityImageView.image = [UIImage imageNamed:@"daiban_normal.png"];
            break;
        case 2:
            self.backLogPriorityImageView.image = [UIImage imageNamed:@"daiban_urgent.png"];
            break;
        case 3:
            self.backLogPriorityImageView.image = [UIImage imageNamed:@"daiban_week.png"];
            break;
        case 4:
            self.backLogPriorityImageView.image = [UIImage imageNamed:@"daiban_other.png"];
            break;
        default:
            break;
    }
//    NSURL * url = [NSURL URLWithString:model.pictureUrl];
//    UIImageView * imageView = [[UIImageView alloc]init];
//    [imageView sd_setImageWithURL:url];
//    [self.backLogImageView addSubview:imageView];
}

-(void)initSubView
{
    [self.contentView addSubview:self.backLogImageView];
    [self.contentView addSubview:self.backLogTitleLabel];
//    [self.contentView addSubview:self.backLogPriorityLabel];
    [self.contentView addSubview:self.backLogDateLabel];
    [self.contentView addSubview:self.backLogPriorityImageView];

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
    
//    [self.backLogPriorityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
//        make.top.mas_equalTo(self.backLogImageView);
//        make.width.mas_equalTo(35 * SA_SCREEN_SCALE);
//        make.height.mas_equalTo(20 * SA_SCREEN_SCALE);
//    }];
//    
    [self.backLogDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backLogTitleLabel);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.backLogImageView);
    }];
    
    [self.backLogPriorityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(0 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.contentView).offset(0 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(50 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(50 * SA_SCREEN_SCALE);
    }];
    
    
}

+(NSString *)cellIdentifier
{
    return @"CSBackLogTableViewCellId";
}

#pragma --mark 懒加载
-(UIImageView *)backLogImageView
{
    if (!_backLogImageView) {
        _backLogImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"banner1"]];
            imageView.layer.cornerRadius = 2 * SA_SCREEN_SCALE;
            imageView;
        });
    }
    return _backLogImageView;
}

-(UILabel *)backLogTitleLabel
{
    if (!_backLogTitleLabel) {
        _backLogTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"xxx事件" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _backLogTitleLabel;
}

-(UILabel *)backLogPriorityLabel
{
    if (!_backLogPriorityLabel) {
        _backLogPriorityLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"紧急" backgroundColor:SA_Color_HexString(0xff0045,1) font:SA_FontPingFangLightWithSize(12) textColor:SA_Color_HexString(0xffffff, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label.layer.cornerRadius = 10 * SA_SCREEN_SCALE;
            label.clipsToBounds = YES;
            label.alpha = 0;
            label;
        });
    }
    return _backLogPriorityLabel;
}

-(UILabel *)backLogDateLabel
{
    if (!_backLogDateLabel) {
        _backLogDateLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"上报时间：2017年4月18日 17:24:01" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:SA_Color_HexString(0x727272, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _backLogDateLabel;
}

-(UIImageView *)backLogPriorityImageView
{
    if (!_backLogPriorityImageView) {
        _backLogPriorityImageView = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"daiban_normal.png"]];
//            imageView.layer.cornerRadius = 2 * SA_SCREEN_SCALE;
            imageView;
        });
    }
    return _backLogPriorityImageView;
}

@end
