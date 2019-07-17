//
//  CSEventFunctionTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/27.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventFunctionTableViewCell.h"

@interface CSEventFunctionTableViewCell ()

@property(nonatomic, strong)NSArray         *titleArray;

@property(nonatomic, strong)UIView          *bottonLineView;    //cell底部线条



@end

@implementation CSEventFunctionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview:self.eventTitleLabel];
    [self.contentView addSubview:self.backLogPriorityLabel];
    [self.contentView addSubview:self.bottonLineView];
    [self.contentView addSubview:self.contentLabel];
    
    [self.backLogPriorityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(60 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(30 * SA_SCREEN_SCALE);
    }];
    
   [self.eventTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.mas_equalTo(self.contentView);
       make.left.mas_equalTo(self.contentView).offset(10*SA_SCREEN_SCALE);
       make.width.mas_equalTo(70*SA_SCREEN_SCALE);
       make.height.mas_equalTo(60*SA_SCREEN_SCALE);
   }];
    
    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_right).offset(60 * SA_SCREEN_SCALE);
        make.left.mas_equalTo(self.eventTitleLabel.mas_right).offset(0*SA_SCREEN_SCALE);
        make.height.mas_equalTo(30 * SA_SCREEN_SCALE);
    }];
    
    
    
    
}




+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"CSEventFunctionTableViewCellID";
}


-(UILabel *)eventTitleLabel
{
    if (!_eventTitleLabel) {
        _eventTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"测试一下" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _eventTitleLabel;
}

-(UILabel *)backLogPriorityLabel
{

    if (!_backLogPriorityLabel) {
        _backLogPriorityLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"请选择>" backgroundColor:[UIColor whiteColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_RgbaValue(52, 213, 105, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label.layer.cornerRadius = 10 * SA_SCREEN_SCALE;
            label.clipsToBounds = YES;
            label;
        });
    }
    return _backLogPriorityLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_RgbaValue(255, 162, 0, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _contentLabel;
}



- (UIView *)bottonLineView {
    if (!_bottonLineView) {
        _bottonLineView = ({
            UIView *view= [SAControlFactory createView:SA_Color_RgbaValue(203, 203, 203, 1) width:SA_SCREEN_WIDTH height:1];
            view;
        });
    }
    return _bottonLineView;
}


@end
