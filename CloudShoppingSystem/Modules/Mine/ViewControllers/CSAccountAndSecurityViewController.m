//
//  CSAccountAndSecurityViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSAccountAndSecurityViewController.h"

@interface CSAccountAndSecurityViewController ()

@property(nonatomic, strong)UILabel         *originalPWTitleLabel;       //原始密码标题
@property(nonatomic, strong)UITextField     *originalPWTextField;        //原始密码
@property(nonatomic, strong)UILabel         *nePWTitleLabel;             //新密码标题
@property(nonatomic, strong)UITextField     *nePWTextField;              //新密码
@property(nonatomic, strong)UILabel         *verifyPWTitleLabel;         //确认密码标题
@property(nonatomic, strong)UITextField     *verifyPWTextField;          //确认密码

@end

@implementation CSAccountAndSecurityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"账号与安全" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *modifyButton = [[UIButton alloc]init];
    modifyButton.backgroundColor = [UIColor clearColor];
    [modifyButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [modifyButton.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
    [modifyButton setTitleColor:SA_Color_HexString(0xffffff, 1) forState:UIControlStateNormal];
    [modifyButton sizeToFit];
    modifyButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    modifyButton.top = (SA_SCREEN_HEIGHT - modifyButton.height)/2;
    [modifyButton addTarget:self action:@selector(modifyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:modifyButton];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

-(void)initSubView
{
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    [bgView addSubview:self.originalPWTextField];
    [bgView addSubview:self.originalPWTitleLabel];
    [bgView addSubview:self.nePWTextField];
    [bgView addSubview:self.nePWTitleLabel];
    [bgView addSubview:self.verifyPWTextField];
    [bgView addSubview:self.verifyPWTitleLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.top.mas_equalTo(self.view);
    }];
    
    [self.originalPWTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.originalPWTextField);
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.width.mas_equalTo(self.originalPWTitleLabel.width);
    }];
    
    [self.originalPWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.originalPWTitleLabel.mas_right).offset(2 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(48 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(SA_NAVBAR_HEIGHT_WITH_STATUS_BAR);
    }];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = SA_Color_HexString(0xf2f2f2, 1);
    [bgView addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(1 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(self.originalPWTextField.mas_bottom);
    }];
    
    [self.nePWTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.nePWTextField);
    }];
    
    [self.nePWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nePWTitleLabel.mas_right).offset(2 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(48 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(lineView1.mas_bottom);
    }];
    
    UIView *lineView2 = [[UIView alloc]init];
    lineView2.backgroundColor = SA_Color_HexString(0xf2f2f2, 1);
    [bgView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(1 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(self.nePWTextField.mas_bottom);
    }];
    
    [self.verifyPWTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20 * SA_SCREEN_SCALE);
        make.centerY.mas_equalTo(self.verifyPWTextField);
    }];
    
    [self.verifyPWTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verifyPWTitleLabel.mas_right).offset(2 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(48 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(lineView2.mas_bottom);
    }];
    
    UIView *lineView3 = [[UIView alloc]init];
    lineView3.backgroundColor = SA_Color_HexString(0xf2f2f2, 1);
    [bgView addSubview:lineView3];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(bgView).offset(-10 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(1 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(self.verifyPWTextField.mas_bottom);
        make.bottom.mas_equalTo(bgView.mas_bottom);
    }];
}

#pragma --mark button clicked
-(void)modifyButtonClicked:(UIButton *)button
{
//    NSString* oldPassword = [self.originalPWTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSString* newPassword = [self.nePWTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSString* verifyPassword = [self.verifyPWTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
//    if (oldPassword.length <= 0 ) {
//        [self showMessageHud:@"请输入原始密码"];
//        return;
//    }
//    if (newPassword.length <= 0 ) {
//        [self showMessageHud:@"请输入新密码"];
//        return;
//    }
//    
//    if (verifyPassword.length <= 0) {
//        [self showMessageHud:@"请确认密码"];
//        return;
//    }
//    
//    if (![verifyPassword isEqualToString:newPassword]) {
//        [self showMessageHud:@"两次输入的修改密码不一致"];
//        return;
//    }

}

#pragma --mark 懒加载
-(UILabel *)originalPWTitleLabel
{
    if (!_originalPWTitleLabel) {
        _originalPWTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"旧密码：" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#333333"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _originalPWTitleLabel;
}

-(UITextField *)originalPWTextField
{
    if (!_originalPWTextField) {
        _originalPWTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            textField.backgroundColor = [UIColor clearColor];
            [textField setFont:SA_FontPingFangRegularWithSize(16)];
            [textField setTextColor:SA_Color_HexString(0x333333, 1)];
            textField.secureTextEntry = YES;
            textField;
        });
    }
    return _originalPWTextField;
}

-(UILabel *)nePWTitleLabel
{
    if (!_nePWTitleLabel) {
        _nePWTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"新密码：" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#333333"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _nePWTitleLabel;
}

-(UITextField *)nePWTextField
{
    if (!_nePWTextField) {
        _nePWTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            textField.backgroundColor = [UIColor clearColor];
            [textField setFont:SA_FontPingFangRegularWithSize(16)];
            [textField setTextColor:SA_Color_HexString(0x333333, 1)];
            textField.secureTextEntry = YES;
            textField;
        });
    }
    return _nePWTextField;
}

-(UILabel *)verifyPWTitleLabel
{
    if (!_verifyPWTitleLabel) {
        _verifyPWTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"再次输入新密码：" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor colorWithHexString:@"#333333"] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _verifyPWTitleLabel;
}

-(UITextField *)verifyPWTextField
{
    if (!_verifyPWTextField) {
        _verifyPWTextField = ({
            UITextField *textField = [[UITextField alloc]init];
            textField.backgroundColor = [UIColor clearColor];
            [textField setFont:SA_FontPingFangRegularWithSize(16)];
            [textField setTextColor:SA_Color_HexString(0x333333, 1)];
            textField.secureTextEntry = YES;
            textField;
        });
    }
    return _verifyPWTextField;
}

@end
