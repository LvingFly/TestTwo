//
//  CSHelpViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSHelpViewController.h"

@interface CSHelpViewController ()<UITextViewDelegate>

@property(nonatomic, strong)UITextView      *adviceTextView;
@property(nonatomic, strong)UILabel         *placeholderLabel;

@end

@implementation CSHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"帮助与反馈" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
    UIButton *submitButton = [[UIButton alloc]init];
    submitButton.backgroundColor = [UIColor clearColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
    [submitButton setTitleColor:SA_Color_HexString(0xffffff, 1) forState:UIControlStateNormal];
    [submitButton sizeToFit];
    submitButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    submitButton.top = (SA_SCREEN_HEIGHT - submitButton.height)/2;
    [submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:submitButton];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

-(void)initSubView
{
    [self.view addSubview:self.adviceTextView];
    [self.adviceTextView addSubview:self.placeholderLabel];
    
    [self.adviceTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(SA_NAVBAR_HEIGHT_WITH_STATUS_BAR + 8 * SA_SCREEN_SCALE);
        make.right.mas_equalTo(8 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(300 * SA_SCREEN_SCALE);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.adviceTextView);
        make.top.mas_equalTo(10 * SA_SCREEN_SCALE);
    }];
}

#pragma --mark button clicked
-(void)submitButtonClicked:(UIButton *)button
{
    
    if (self.adviceTextView.text.length == 0) {
        [self showError:@"请填写提交内容"];
    }else {
        [self showError:@"提交成功"];
        self.adviceTextView.text = @"";
    }
}

#pragma --mark UITextView delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeholderLabel.hidden = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }else
    {
        _placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}

#pragma --mark 懒加载
-(UITextView *)adviceTextView
{
    if (!_adviceTextView) {
        _adviceTextView = ({
            UITextView *view = [[UITextView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 6 * SA_SCREEN_SCALE;
            [view setFont:SA_FontPingFangRegularWithSize(16)];
            [view setTextColor:SA_Color_HexString(0x333333, 1)];
            view.layer.borderWidth = 1 * SA_SCREEN_SCALE;
            view.layer.borderColor = SA_Color_HexString(0x99cccc, 1).CGColor;
            view.dataDetectorTypes = UIDataDetectorTypeAll;
            view.delegate = self;
            view;
        });
    }
    return _adviceTextView;
}

-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"请在此输入您的意见与建议" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:[UIColor colorWithHexString:@"#727272"] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _placeholderLabel;
}

- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

@end
