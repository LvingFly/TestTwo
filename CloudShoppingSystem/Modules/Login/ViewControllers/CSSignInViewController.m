//
//  CSSignInViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSSignInViewController.h"

@interface CSSignInViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField         *countryCodeTextField;          //国家代码
@property(nonatomic, strong)UITextField         *phoneTextField;                //手机号
@property(nonatomic, strong)UITextField         *codeTextField;                 //验证码
@property(nonatomic, strong)UIButton            *getCodeButton;                 //获取验证码
@property(nonatomic, strong)UITextField         *passwordTextField;             //密码
@property(nonatomic, strong)UIButton            *signInButton;                  //注册

@end

@implementation CSSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)initNavButtons
{
    UILabel *titleLabel = [SAControlFactory createLabel:@"注册" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *loginButton = [[UIButton alloc]init];
    loginButton.backgroundColor = [UIColor clearColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:SA_FontPingFangRegularWithSize(18)];
    [loginButton setTitleColor:SA_Color_HexString(0x666666, 1) forState:UIControlStateNormal];
    [loginButton sizeToFit];
    loginButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    loginButton.top = (SA_SCREEN_HEIGHT - loginButton.height)/2;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:loginButton];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

-(void)initSubView
{
    [self.view addSubview:self.countryCodeTextField];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.codeTextField];
    [self.view addSubview:self.getCodeButton];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.signInButton];
    
    [self.countryCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SA_NAVBAR_HEIGHT_WITH_STATUS_BAR + 12.5 * SA_SCREEN_SCALE);
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(85 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(50 * SA_SCREEN_SCALE);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countryCodeTextField.mas_right).offset(1 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.view).offset(-20 * SA_SCREEN_SCALE);
        make.height.centerY.mas_equalTo(self.countryCodeTextField);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.mas_equalTo(self.countryCodeTextField);
        make.top.mas_equalTo(self.countryCodeTextField.mas_bottom).offset(10 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.getCodeButton.mas_left).offset(-1 * SA_SCREEN_SCALE);
    }];
    
    [self.getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(self.codeTextField);
        make.width.mas_equalTo(85 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(self.phoneTextField);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.mas_equalTo(self.countryCodeTextField);
        make.right.mas_equalTo(self.phoneTextField);
        make.top.mas_equalTo(self.codeTextField.mas_bottom).offset(10 * SA_SCREEN_SCALE);
    }];
    
    [self.signInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(self.passwordTextField);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(20 * SA_SCREEN_SCALE);
    }];
}

#pragma --mark button clicked
-(void)loginButtonClicked:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma --mark UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.countryCodeTextField) {
        return NO;
    }
    return YES;
}

#pragma --mark 懒加载
-(UITextField *)countryCodeTextField
{
    if (!_countryCodeTextField) {
        _countryCodeTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(14)];
            [textField setTextColor:[UIColor blackColor]];
            textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeyDone;
            [textField setText:@"+86"];
            textField;
        });
    }
    return _countryCodeTextField;
}

-(UITextField *)phoneTextField
{
    if (!_phoneTextField) {
        _phoneTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(14)];
            [textField setTextColor:[UIColor blackColor]];
            textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeyDone;
            textField.placeholder = @"请输入手机号";
            textField;
        });
    }
    return _phoneTextField;
}

-(UITextField *)codeTextField
{
    if (!_codeTextField) {
        _codeTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(14)];
            [textField setTextColor:[UIColor blackColor]];
            textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeyDone;
            textField.placeholder = @"请输入验证码";
            textField;
        });
    }
    return _codeTextField;
}

-(UIButton *)getCodeButton
{
    if(!_getCodeButton)
    {
        _getCodeButton = ({
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            [button setTitleColor:SA_Color_RgbaValue(139, 184, 61, 1) forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(14)];
            button;
        });
    }
    return _getCodeButton;
}

-(UITextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            [textField setFont:SA_FontPingFangRegularWithSize(14)];
            [textField setTextColor:[UIColor blackColor]];
            textField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            textField.delegate = self;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.returnKeyType = UIReturnKeyDone;
            textField.placeholder = @"输入密码";
            textField;
        });
    }
    return _passwordTextField;
}

-(UIButton *)signInButton
{
    if (!_signInButton) {
        _signInButton = ({
            UIButton *button = [[UIButton alloc]init];
            button.backgroundColor = [UIColor colorWithHexString:@"#f1a52a"];
            [button setTitle:@"注册" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(14)];
            button;
        });
    }
    return _signInButton;
}

@end
