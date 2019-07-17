//
//  CSSelectorPickView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSelectorPickView.h"

#define iOS9_Beyond ([[UIDevice currentDevice].systemVersion doubleValue]>=9.0)


@interface CSSelectorPickView()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSString *_disaccount;
}
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIButton *sureButton;
@property(nonatomic,strong)UIButton *canclebutton;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)NSArray *sencondArray;
@property(nonatomic,assign)NSInteger selectIndex;

@property (nonatomic, strong) NSString *selectID;

@end

@implementation CSSelectorPickView
- (instancetype)initWithDataArray:(NSArray *)dataArra
{
    self = [super init];
    if (self) {
        _dataArray = dataArra;
        [self initializedInterface];
    }
    return self;
}
- (instancetype)initWithDataArray:(NSArray *)dataArra WithSelectID:(NSString *)selectID {
    self = [super init];
    if (self) {
        _dataArray = dataArra;
        self.selectID = selectID;
        [self initializedInterface];
    }
    return self;
}


-(void)initializedInterface{
    self.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT);
    _selectIndex = 0;
    self.backgroundColor = SA_Color_HexString(0x000000, 0.5);
    [self addSubview:self.sureButton];
    [self addSubview:self.pickerView];
    //先确定按钮的约束 再添加选择器的约束
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.height.mas_equalTo(50*SA_SCREEN_SCALE);
        make.bottom.mas_equalTo(self).offset(-5);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(5);
        make.right.mas_equalTo(self).offset(-5);
        make.bottom.mas_equalTo(self.sureButton.mas_top).offset(-10);
        make.height.mas_equalTo(209*SA_SCREEN_SCALE);

    } ];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    if (_dataArray.count > 1) {
      _disaccount = _dataArray[1];
    }else  {
        _disaccount = _dataArray[0];
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
#pragma mark - pickerView 代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArray.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectIndex = row;
    _disaccount = _dataArray[row];
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 65;
}
#pragma mark -  按钮点击事件
-(void)responseToSureButton{
    
    if ([self.selectID  isEqual: @"1"] ) {
        if ([self.delegate respondsToSelector:@selector(pickViewSelectItem:WithSelectString:)]) {
            [self.delegate pickViewSelectItem:_disaccount WithSelectString:self.selectID];
        }

    }else {
        if ([self.delegate respondsToSelector:@selector(pickViewSelectItem:)]) {
            [self.delegate pickViewSelectItem:_disaccount];
        }
    }
    
    if (_block) {
        _block(_disaccount);
    }
    [self dismiss];
}
-(void)responseToCancleButton{
    [self dismiss];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SA_SCREEN_WIDTH, 50)];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.text = _dataArray[row];
    myView.font = [UIFont boldSystemFontOfSize:16];         //用label来设置字体大小
    myView.adjustsFontSizeToFitWidth = YES;
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}
-(void)dismiss{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)dealloc {
    
    
}


#pragma mark --懒加载
-(UIPickerView *)pickerView{
    if (!_pickerView) {
        if (iOS9_Beyond) {
            _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SA_SCREEN_HEIGHT-400,SA_SCREEN_WIDTH, 120*SA_SCREEN_SCALE)];
        }else{
            _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SA_SCREEN_HEIGHT-400,SA_SCREEN_WIDTH, 120*SA_SCREEN_SCALE)];
        }
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.layer.cornerRadius = 5.0;
        _pickerView.layer.masksToBounds = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource =self;
        [_pickerView selectRow: 1 inComponent:0 animated:NO];
    }
    return _pickerView;
}
-(UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.backgroundColor = [UIColor whiteColor];
        [_sureButton setTitleColor:SA_Color_RgbaValue(52, 213, 105, 1) forState:UIControlStateNormal];
        _sureButton.layer.cornerRadius = 5.0;
        _sureButton.layer.masksToBounds = YES;
        [_sureButton addTarget:self action:@selector(responseToSureButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}


@end
