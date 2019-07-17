//
//  CSEventFunctionTextCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/28.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventFunctionTextCell.h"

@interface CSEventFunctionTextCell ()<UITextFieldDelegate>


@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong)UIView          *bottonLineView;    //cell底部线条

@end

@implementation CSEventFunctionTextCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

//布局cell内部控件
- (void)initSubView {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentText];
    [self.contentView addSubview:self.bottonLineView];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(10*SA_SCREEN_SCALE);
        make.width.mas_equalTo(70*SA_SCREEN_SCALE);
        make.height.mas_equalTo(60*SA_SCREEN_SCALE);
    }];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(7);
        make.left.mas_equalTo(self.titleLabel).offset(70*SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.contentView).offset(10);
        make.bottom.mas_equalTo(self.contentView).offset(-5);


    }];
    
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
    return @"CSEventFunctionTextCellID";
}


-(void)setTitle:(NSString *)title
{
    _title = title;
    if (_title) {
        [self.titleLabel setText:_title];
    }
}

- (void)setActionString:(NSString *)actionString {
    _actionString = actionString;
    if (_actionString) {
        [self.contentText setPlaceholder:_actionString];
    }
}

#pragma mark  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark  懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:self.title backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail];
            label;
        });
    }
    return _titleLabel;
}

- (UITextField *)contentText {
    if (!_contentText) {
        _contentText = ({
            UITextField *text = [[UITextField alloc] init];
            text.textColor = SA_Color_RgbaValue(255, 162, 0, 1);
            text.textAlignment = NSTextAlignmentLeft;
            text.placeholder = self.actionString;
            text.returnKeyType =UIReturnKeyDone;
            text.delegate = self;
            text;
        });
        
    }
    return _contentText;
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

