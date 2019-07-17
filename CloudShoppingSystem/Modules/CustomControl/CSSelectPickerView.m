//
//  CSSelectPickerView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSelectPickerView.h"

@interface CSSelectPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger  selectIndex;
}

@property(nonatomic, strong)UIPickerView        *pickerView;
@property(nonatomic, strong)UILabel             *titleLabel;
@property(nonatomic, strong)UIButton            *cancelButton;
@property(nonatomic, strong)UIButton            *comfirmButton;

@property(nonatomic, strong)UILabel             *pickerContentLabel;
@property(nonatomic, copy)NSArray             *dataListArray;

@end

@implementation CSSelectPickerView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataListArray = [dataArray copy];
        selectIndex = 0;
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
    [bgView addSubview:self.pickerView];
    
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
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleBgView.mas_bottom);
        make.width.left.bottom.mas_equalTo(bgView);
    }];
}

-(void)didSelectItemAtIndex:(SelectItemBlock)block
{
    self.selectItemBlock = block;
}

-(void)closeSelf
{
    [self removeFromSuperview];
}

-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    [self.titleLabel setText:titleString];
}

#pragma --mark button clicked
-(void)cancelButtonClicked:(UIButton *)button
{
    [self closeSelf];
}

-(void)comfirmButtonClicked:(UIButton *)button
{
    
    if (self.selectItemBlock != nil) {
        self.selectItemBlock(selectIndex);
        [self closeSelf];
    }
}

#pragma mark - UIPickerViewDataSource Methods
- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *dataLabel = (UILabel *)view;
    if (!dataLabel) {
        dataLabel = [SAControlFactory createLabel:@"" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    if (row < self.dataListArray.count) {
        NSString *string = [self.dataListArray objectAtIndex:row];
        dataLabel.text = string;
    }
//    switch (component) {
//        case 0: {
//            NSDateComponents *components = [self.calendar components:NSCalendarUnitYear
//                                                            fromDate:self.pickerStartDate];
//            NSString *currentYear = [NSString stringWithFormat:@"%ld年", [components year] + row];
//            [dateLabel setText:currentYear];
//            dateLabel.textAlignment = NSTextAlignmentCenter;
//            break;
//        }
//        case 1: {
//            NSString *currentMonth = [NSString stringWithFormat:@"%ld月",(long)row+1];
//            [dateLabel setText:currentMonth];
//            dateLabel.textAlignment = NSTextAlignmentCenter;
//            break;
//        }
//        case 2: {
//            NSRange dateRange = [self.calendar rangeOfUnit:NSCalendarUnitDay
//                                                    inUnit:NSCalendarUnitMonth
//                                                   forDate:self.selectedDate];
//            
//            NSString *currentDay = [NSString stringWithFormat:@"%lu日", (row + 1) % (dateRange.length + 1)];
//            [dateLabel setText:currentDay];
//            dateLabel.textAlignment = NSTextAlignmentCenter;
//            break;
//        }
//        case 3:{
//            NSString *currentHour = [NSString stringWithFormat:@"%ld时",(long)row];
//            [dateLabel setText:currentHour];
//            dateLabel.textAlignment = NSTextAlignmentCenter;
//            break;
//        }
//        case 4:{
//            NSString *currentMin = [NSString stringWithFormat:@"%02ld分",row];
//            [dateLabel setText:currentMin];
//            dateLabel.textAlignment = NSTextAlignmentCenter;
//        }
//        default:
//            break;
//    }
    
    return dataLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataListArray.count;
}

#pragma mark - UIPickerViewDelegate Methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectIndex = row;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35.0 * SA_SCREEN_SCALE;
}

#pragma --mark 懒加载
-(UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = ({
            UIPickerView *pickerView = [[UIPickerView alloc]init];
            pickerView.backgroundColor = [UIColor whiteColor];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView;
        });
    }
    return _pickerView;
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
