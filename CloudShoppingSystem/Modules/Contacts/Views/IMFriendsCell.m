//
//  IMFriendsCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "IMFriendsCell.h"


@interface IMFriendsCell ()

@property(nonatomic, strong)NSArray         *titleArray;

@property(nonatomic, strong)UIView          *bottonLineView;    //cell底部线条

@end

@implementation IMFriendsCell


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
    [self.contentView addSubview:self.bottonLineView];
    [self.contentView addSubview:self.headerImage];
//    [self.contentView addSubview:self.nameLabel];


    
    [self.eventTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(80*SA_SCREEN_SCALE);
        make.width.mas_equalTo(100*SA_SCREEN_SCALE);
        make.height.mas_equalTo(50*SA_SCREEN_SCALE);
    }];
    
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(10*SA_SCREEN_SCALE);
        make.width.mas_equalTo(40*SA_SCREEN_SCALE);
        make.height.mas_equalTo(40*SA_SCREEN_SCALE);
    }];
    
    
    
    
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.contentView);
//        make.right.mas_equalTo(self.contentView).offset(-20*SA_SCREEN_SCALE);
//        make.width.mas_equalTo(80*SA_SCREEN_SCALE);
//        make.height.mas_equalTo(60*SA_SCREEN_SCALE);
//    }];
    
    
    [self.bottonLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(0);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
   
    
    
    
    
}




+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"IMFriendsTableViewCellID";
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

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"这只是个测试" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _nameLabel;
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

- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage imageNamed:@"head_IM_02.png"];
            imageView;
        });
    }
    return _headerImage;
}



@end
