//
//  CSDatePickerView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/15.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSDatePickerView.h"

@interface CSDatePickerView ()

@property(nonatomic, strong)UIDatePicker        *datePickerView;
@property(nonatomic, strong)UILabel             *titleLabel;
@property(nonatomic, strong)UIButton            *cancelButton;
@property(nonatomic, strong)UIButton            *comfirmButton;

@property(nonatomic, strong)UILabel             *pickerContentLabel;
@property(nonatomic, copy)NSArray             *dataListArray;
@property(nonatomic, strong)NSString            *selectDateString;
@property(nonatomic, strong)NSDateFormatter     *dateFormatter;

@end

@implementation CSDatePickerView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataListArray = [dataArray copy];
         self.dateFormatter = [[NSDateFormatter alloc]init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd"];
        self.selectDateString = [self.dateFormatter stringFromDate:[NSDate date]];
        [self initSubView];
        self.backgroundColor = SA_Color_HexString(0x000000, 0.5);
    }
    return self;
}

-(void)initSubView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UIView *titleBgView = [[UIView alloc]init];
    titleBgView.backgroundColor = [UIColor colorWithHexString:@"#34d569"];
    [bgView addSubview:titleBgView];
    [bgView addSubview:self.datePickerView];
    
    [titleBgView addSubview:self.cancelButton];
    [titleBgView addSubview:self.comfirmButton];
    [titleBgView addSubview:self.titleLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(self);
        make.height.mas_equalTo(201 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self);
    }];
    
    [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.mas_equalTo(bgView);
        make.height.mas_equalTo(45 * SA_SCREEN_SCALE);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(titleBgView);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(titleBgView);
    }];
    
    [self.comfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(titleBgView).offset(-23 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(titleBgView);
    }];
    
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleBgView.mas_bottom);
        make.width.left.bottom.mas_equalTo(bgView);
    }];
}

-(void)didSelectDateAtIndex:(SelectDateBlock)block
{
    self.selectDateBlock = block;
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}

-(void)closeSelf
{
    [self removeFromSuperview];
}

#pragma --mark button clicked
-(void)cancelButtonClicked:(UIButton *)button
{
    [self closeSelf];
}

-(void)comfirmButtonClicked:(UIButton *)button
{
    if (self.selectDateBlock != nil) {
        self.selectDateBlock(_selectDateString);
        [self closeSelf];
    }
}

-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    /*添加你自己响应代码*/
    NSDate *date = control.date;
    self.selectDateString = [self.dateFormatter stringFromDate:date];
}

#pragma --mark 懒加载

-(UIDatePicker *)datePickerView
{
    if (!_datePickerView) {
        _datePickerView = ({
            UIDatePicker *datePicker = [[UIDatePicker alloc]init];
            datePicker.backgroundColor = [UIColor whiteColor];
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker setDate:[NSDate date]];
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
            datePicker;
        });
    }
    return _datePickerView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"期望起租日期" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0xffffff, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _titleLabel;
}

-(UIButton *)comfirmButton
{
    if (!_comfirmButton) {
        _comfirmButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"确定" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
            [button addTarget:self action:@selector(comfirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _comfirmButton;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
            [button addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cancelButton;
}

-(UILabel *)pickerContentLabel
{
    if (!_pickerContentLabel) {
        _pickerContentLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"XX" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x000000, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _pickerContentLabel;
}

@end
