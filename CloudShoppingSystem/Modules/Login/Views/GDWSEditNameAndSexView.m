//
//  GDWSEditNameAndSexView.m
//  Mall_GDWS
//
//  Created by Dengyuchi on 16/6/7.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSEditNameAndSexView.h"

@interface GDWSEditNameAndSexView()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSString *sexSelect;    //male 表示男性 female 表示女性
}

@property(nonatomic ,strong)UILabel *guideTitleLabel;
@property(nonatomic ,strong)UIView *textFieldBgView;
@property(nonatomic ,strong)UITextField *nameTextField;
@property(nonatomic ,strong)UILabel *orLabel;
@property(nonatomic ,strong)UIButton *maleSelectButton;
@property(nonatomic ,strong)UIButton *femaleSelectButton;
@property(nonatomic ,strong)UIButton *continueButton;

@end

@implementation GDWSEditNameAndSexView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self initView];
        _userName = nil;
        sexSelect = @"0";
        //添加手势
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTapped:)];
        tapRecognizer.delegate = self;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

-(void)initView
{
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.guideTitleLabel];
    [self addSubview:self.textFieldBgView];
    [self.textFieldBgView addSubview:self.nameTextField];
    [self addSubview:self.orLabel];
    [self addSubview:self.maleSelectButton];
    [self addSubview:self.femaleSelectButton];
    [self addSubview:self.continueButton];
    
    [self.guideTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    [self.textFieldBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.guideTitleLabel.mas_bottom).offset(30 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.width.mas_equalTo(280 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(40 * SA_SCREEN_SCALE);
    }];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(weakSelf.textFieldBgView);
        make.top.left.mas_equalTo(0);
    }];
    
    [self.maleSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(75 * SA_SCREEN_SCALE);
        make.left.mas_equalTo(83 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(weakSelf.textFieldBgView.mas_bottom).offset(35 * SA_SCREEN_SCALE);
    }];
    
    [self.orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.maleSelectButton.mas_centerY);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    [self.femaleSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(75 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-82 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(weakSelf.maleSelectButton.mas_centerY);
    }];
    
    [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.maleSelectButton.mas_bottom).offset(41 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
}

#pragma -mark 懒加载
-(UILabel *)guideTitleLabel
{
    if(!_guideTitleLabel)
    {
        _guideTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"我的名字叫..." backgroundColor:[UIColor clearColor] font:SA_FontWithSize(24) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _guideTitleLabel;
}

-(UIView *)textFieldBgView
{
    if (!_textFieldBgView) {
        _textFieldBgView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
            view;
        });
    }
    return _textFieldBgView;
}

-(UITextField *)nameTextField
{
    if(!_nameTextField)
    {
        _nameTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            textField.backgroundColor = [UIColor clearColor];
            [textField setFont:SA_FontWithSize(14)];
            [textField setTextAlignment:NSTextAlignmentCenter];
            textField.placeholder = @"取个昵称吧";
            textField.returnKeyType = UIReturnKeyDone;
            [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            textField.delegate = self;
            textField;
        });
    }
    return _nameTextField;
}

-(UILabel *)orLabel
{
    if (!_orLabel) {
        _orLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"or" backgroundColor:[UIColor clearColor] font:SA_FontWithSize(18) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _orLabel;
}

-(UIButton *)maleSelectButton
{
    if (!_maleSelectButton) {
        _maleSelectButton = ({
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = [UIColor clearColor];
            [button setImage:[UIImage imageNamed:@"male"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"maleon"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(maleSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 2001;
            button.selected = NO;
            button.adjustsImageWhenHighlighted = NO;
            button;
        });
    }
    return _maleSelectButton;
}

-(UIButton *)femaleSelectButton
{
    if (!_femaleSelectButton) {
        _femaleSelectButton = ({
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = [UIColor clearColor];
            [button setImage:[UIImage imageNamed:@"female"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"femaleon"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(femaleSelected:) forControlEvents:UIControlEventTouchUpInside];
            button.selected = NO;
            button.adjustsImageWhenHighlighted = NO;
            button.tag = 2002;
            button;
        });
    }
    return _femaleSelectButton;
}

-(UIButton *)continueButton
{
    if (!_continueButton) {
        _continueButton = ({
            UIButton *button = [[UIButton alloc]init];
            button.titleLabel.font = SA_FontWithSize(18);
            button.backgroundColor = [UIColor clearColor];
            [button setTitleColor:[UIColor colorWithHexString:@"#030303"] forState:UIControlStateNormal];
            [button setTitle:@"继续" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(continueButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            button;
        });
    }
    return _continueButton;
}

#pragma --mark button clicked

-(void)maleSelected:(UIButton *)button
{
    if (button.selected == NO) {
        UIButton *femaleButton = [self viewWithTag:2002];
        femaleButton.selected = NO;
        button.selected = YES;
    }
    sexSelect = @"1";
}

-(void)femaleSelected:(UIButton *)button
{
    if (button.selected == NO) {
        UIButton *maleButton = [self viewWithTag:2001];
        maleButton.selected = NO;
        button.selected = YES;
    }
    sexSelect = @"2";
}

-(void)continueButtonClicked:(UIButton *)button
{
    if (self.userName == nil || [self.userName isKindOfClass:[NSNull class]] || self.userName == NULL || [[self.userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]] length]==0) {
        [self showMessageHud:@"要输入一个昵称哦！"];
        return;
    }
    
    if ([sexSelect isEqualToString:@"0"]) {
        [self showMessageHud:@"请选择性别!"];
        return;
    }
    [self showHudForLoading];
    
    __weak typeof(self) weakSelf = self;
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager updateUserInfoWithUid:[SAUserInforManager shareManager].userID
 headImage:nil nickName:self.userName sex:sexSelect place:nil callBack:^(id resp, NSError *error) {
     [self hideHude];
         if (!error){
             NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]]?(NSDictionary*)resp:nil;
             NSLog(@"updatauserinfo%@",dicData);
             if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 0) {
                 [weakSelf showMessageHud:@"提交成功!" delaySecondsForHide:2.0];
                 [[NSUserDefaults standardUserDefaults] setObject:weakSelf.userName forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] setObject:sexSelect forKey:@"sex"];
                 
                 if([weakSelf.deleagte respondsToSelector:@selector(continueClicked)])
                 {
                     [weakSelf.deleagte continueClicked];
                 }
             }
             else{
                 if (dicData && [[dicData validValueForKey:@"errcode"] integerValue] == 1) {
                     NSString *errorMessage = @"提交失败，请重试!";
                     if ([dicData validValueForKey:@"errmsg"]) {
                         errorMessage = [dicData validValueForKey:@"errmsg"];
                     }
                     [self showMessageHud:errorMessage delaySecondsForHide:2.0];
                 }
             }
         }
         else{
             NSString *errorMessage = @"登录失败，请重试！";
             if ([error code] == KNoNetWorkErrorCode)
             {
                 errorMessage = @"网络已断开，请检查您的网络连接！";
             }
            [self showMessageHud:errorMessage delaySecondsForHide:2.0];
         }
    }];
}

#pragma --mark delegte
#pragma --mark textField delegte
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        if (textField.text.length > 15) {
            textField.text = [textField.text substringToIndex:15];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.userName = textField.text;
}

#pragma -mark UIGestureRecognizer delegate
-(void)selfTapped:(UIGestureRecognizer*)recognizer
{
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view == self.nameTextField){
        [self.nameTextField becomeFirstResponder];
    }else{
        [self.nameTextField resignFirstResponder];
    }
    
    return YES;
}

@end
