//
//  WZLoginViewController.m
//  FeiTianDuoBao
//
//  Created by Dengyuchi on 16/3/31.
//  Copyright © 2016年 dengyuchi. All rights reserved.
//

#import "CSLoginViewController.h"
#import "AppDelegate.h"
#import "SNNavigationController.h"
#import "CSSignInViewController.h"

#define KLeftMargin 56 * SA_SCREEN_SCALE
#define KRightMarin 48 * SA_SCREEN_SCALE
#define KMiddleSpace 20 * SA_SCREEN_SCALE

@interface CSLoginViewController ()<UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    BOOL isPressCodeButton;
}

@property(nonatomic, strong)UITextField             *userNameField;
@property(nonatomic, strong)UITextField             *codeField;
@property(nonatomic, weak)SAUserInforManager        *userInforManager;
@property(nonatomic, strong)UIButton                *signInButton;          //注册
@property(nonatomic, strong)UIButton                *forgetPWButton;        //忘记密码
@property(nonatomic, strong)UIButton                *wechatButton;          //微信登录
@property(nonatomic, strong)UIButton                *sinaWeiboButton;       //新浪微博登录
@property(nonatomic, strong)UIButton                *qqLoginButton;         //qq登录

@property(nonatomic, strong)UIButton                *clearUserNameButton;
@property(nonatomic, strong)UIButton                *clearcodeButton;

@end

@implementation CSLoginViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
    self.userInforManager = [SAUserInforManager shareManager];

    [self registNotificationAndKVO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
   // isPressCodeButton = _getCode.selected;
}

-(void)registNotificationAndKVO
{
//    [self.userInforManager addObserver:self forKeyPath:@"isAuthValid" options:NSKeyValueObservingOptionNew context:nil];
//    [self.userInforManager addObserver:self forKeyPath:@"error" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userNameTextFieldChanged:) name:UITextFieldTextDidChangeNotification object:self.userNameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(codeTextFieldChanged:) name:UITextFieldTextDidChangeNotification object:self.codeField];
}

-(void)removeNotificationAndKVO
{
//    [self.userInforManager removeObserver:self forKeyPath:@"isAuthValid"];
//    [self.userInforManager removeObserver:self forKeyPath:@"error"];
//    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)clearcode
{
    self.codeField.text = @"";
    self.clearcodeButton.hidden = YES;
}

#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.userInforManager)
    {
        if (self.userInforManager.isAuthValid) {

            if (self.userInforManager.isNew == 0) {
                [self.view showMessageHud:@"登录成功"];
                [self backAction];
            }
            else
            {
            }
    }
    else if ([keyPath isEqualToString:@"error"]) {
        NSString *errorMessage = [self.userInforManager.error.userInfo validValueForKey:NSLocalizedDescriptionKey];
        [self.view showMessageHud:errorMessage];
        }
    }
}

- (void)initSubViews{
    //导航栏
    UIImageView* fakeNavBarView = [[UIImageView alloc]init];
    fakeNavBarView.backgroundColor = [UIColor clearColor];
    fakeNavBarView.width = SA_SCREEN_WIDTH;
    fakeNavBarView.height = SA_NAVBAR_HEIGHT_WITH_STATUS_BAR;
    fakeNavBarView.top = 0;
    fakeNavBarView.left = 0;
    fakeNavBarView.userInteractionEnabled = YES;
    [self.view addSubview:fakeNavBarView];
    
    UILabel *label = [SAControlFactory createLabel:@"登录" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    label.centerX = SA_SCREEN_WIDTH / 2;
    label.top = SA_STATUSBAR_HEIGHT + (SA_NAVBAR_HEIGHT - label.height)/2;
    [fakeNavBarView addSubview:label];
    
    self.signInButton = [[UIButton alloc]init];
    self.signInButton.backgroundColor = [UIColor clearColor];
    [self.signInButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.signInButton.titleLabel setFont:SA_FontPingFangRegularWithSize(18)];
    [self.signInButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.signInButton addTarget:self action:@selector(signInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [fakeNavBarView addSubview:self.signInButton];
    self.signInButton.hidden = YES;
    self.signInButton.userInteractionEnabled = NO;
    [self.signInButton sizeToFit];
    self.signInButton.right = fakeNavBarView.width - 15 * SA_SCREEN_SCALE;
    self.signInButton.centerY = label.centerY;
    
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.top = fakeNavBarView.bottom;
    scrollView.left = 0;
    [self.view addSubview:scrollView];
    
    self.userNameField = [[UITextField alloc]init];
    self.userNameField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.userNameField.delegate = self;
    self.userNameField.width = scrollView.width - 2 * KMiddleSpace;
    self.userNameField.textAlignment = NSTextAlignmentCenter;
    self.userNameField.height = 50 * SA_SCREEN_SCALE;
    self.userNameField.left = KMiddleSpace;
    self.userNameField.top = 25 * SA_SCREEN_SCALE;
    self.userNameField.returnKeyType = UIReturnKeyDone;
    self.userNameField.font = SA_FontPingFangLightWithSize(14);
    self.userNameField.placeholder = @"请输入账号";
    [scrollView addSubview:self.userNameField];
    
    [scrollView addSubview:self.clearUserNameButton];
    self.clearUserNameButton.centerY = self.userNameField.centerY;
    self.clearUserNameButton.right = scrollView.width - KMiddleSpace - 10 * SA_SCREEN_SCALE;
    self.clearUserNameButton.hidden = YES;
    
    self.codeField = [[UITextField alloc]init];
    self.codeField.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    self.codeField.delegate = self;
    self.codeField.textAlignment = NSTextAlignmentCenter;
    self.codeField.width = self.userNameField.width;
    self.codeField.height = self.userNameField.height;
    self.codeField.left = self.userNameField.left;
    self.codeField.top = self.userNameField.bottom + 10 * SA_SCREEN_SCALE;
    self.codeField.font = SA_FontPingFangLightWithSize(14);
   // [self.codeField setSecureTextEntry:YES];
    self.codeField.returnKeyType = UIReturnKeyDone;
   // self.codeField.placeholder = @"请输入6位以上密码";
    [scrollView addSubview:self.codeField];
    
    [scrollView addSubview:self.clearcodeButton];
    self.clearcodeButton.centerY = self.codeField.centerY;
    self.clearcodeButton.right = scrollView.width - KMiddleSpace - 10 * SA_SCREEN_SCALE;
    self.clearcodeButton.hidden = YES;
    
    UIButton* loginButton = [[UIButton alloc] init];
    loginButton.backgroundColor = [UIColor colorWithHexString:@"#f1a52a"];
    loginButton.titleLabel.font = SA_FontPingFangRegularWithSize(18);
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton sizeToFit];
    loginButton.left = self.userNameField.left;
    loginButton.top = self.codeField.bottom + 20 * SA_SCREEN_SCALE;
    loginButton.width = self.userNameField.width;
    loginButton.height = self.userNameField.height;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginButton];
    
    self.forgetPWButton = [[UIButton alloc]init];
    self.forgetPWButton.backgroundColor = [UIColor clearColor];
    [self.forgetPWButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetPWButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [self.forgetPWButton.titleLabel setFont:SA_FontPingFangRegularWithSize(14)];
    [scrollView addSubview:self.forgetPWButton];
    [self.forgetPWButton sizeToFit];
    self.forgetPWButton.hidden = YES;
    self.forgetPWButton.userInteractionEnabled = NO;
    self.forgetPWButton.right = scrollView.width - 30 * SA_SCREEN_SCALE;
    self.forgetPWButton.top = loginButton.bottom + 10 * SA_SCREEN_SCALE;
    
    UILabel *otherLoginLabel = [SAControlFactory createLabel:@"其他登录方式" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(14) textColor:[UIColor colorWithHexString:@"#666666"] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    otherLoginLabel.centerX = self.userNameField.centerX;
    otherLoginLabel.top = self.forgetPWButton.bottom + 80 * SA_SCREEN_SCALE ;
//    [scrollView addSubview:otherLoginLabel];
    
    self.wechatButton = [[UIButton alloc]init];
    [self.wechatButton setImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
    self.wechatButton.backgroundColor = [UIColor clearColor];
    [self.wechatButton sizeToFit];
//    [scrollView addSubview:self.wechatButton];
    
    self.sinaWeiboButton = [[UIButton alloc]init];
    [self.sinaWeiboButton setImage:[UIImage imageNamed:@"login_sina"] forState:UIControlStateNormal];
    self.sinaWeiboButton.backgroundColor = [UIColor clearColor];
    [self.sinaWeiboButton sizeToFit];
//    [scrollView addSubview:self.sinaWeiboButton];
    
    self.qqLoginButton = [[UIButton alloc]init];
    [self.qqLoginButton setImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
    self.qqLoginButton.backgroundColor = [UIColor clearColor];
    [self.qqLoginButton sizeToFit];
//    [scrollView addSubview:self.qqLoginButton];
    
//    self.sinaWeiboButton.centerX = self.userNameField.centerX;
//    self.sinaWeiboButton.top = otherLoginLabel.bottom + 30 * SA_SCREEN_SCALE;
//    
//    self.wechatButton.centerY = self.sinaWeiboButton.centerY;
//    self.wechatButton.right = self.sinaWeiboButton.left - 30 * SA_SCREEN_SCALE;
//    
//    self.qqLoginButton.centerY = self.sinaWeiboButton.centerY;
//    self.qqLoginButton.left = self.sinaWeiboButton.right + 30 * SA_SCREEN_SCALE;
    
    //添加手势
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTapped:)];
    tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapRecognizer];
    
    self.userNameField.text = [SAUserInforManager shareManager].telNumber;
    if (self.userNameField.text.length > 0) {
        self.clearUserNameButton.hidden = NO;
    }
    
    self.userNameField.text =  @"llf";
    self.codeField.text = @"123456";
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIButton*)clearUserNameButton
{
    if (_clearUserNameButton == nil) {
        _clearUserNameButton = [[UIButton alloc]init];
        _clearUserNameButton.backgroundColor = [UIColor clearColor];
        [_clearUserNameButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_clearUserNameButton sizeToFit];
        [_clearUserNameButton addTarget:self action:@selector(clearUserNameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_clearUserNameButton setEnlargeEdge:10];
    }
    
    return _clearUserNameButton;
}

-(UIButton*)clearcodeButton
{
    if (_clearcodeButton == nil) {
        _clearcodeButton = [[UIButton alloc]init];
        _clearcodeButton.backgroundColor = [UIColor clearColor];
        [_clearcodeButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_clearcodeButton sizeToFit];
        [_clearcodeButton addTarget:self action:@selector(clearcodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_clearcodeButton setEnlargeEdge:10];
    }
    
    return _clearcodeButton;
}

- (void)dealloc
{
    [self removeNotificationAndKVO];
    NSLog(@"dealloc");
}

//判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(instancetype)shareLoginController{
    static dispatch_once_t once;
    static CSLoginViewController *sharedViewController;
    dispatch_once(&once, ^ {
        sharedViewController = [[CSLoginViewController alloc] init];
    });
    return sharedViewController;
}

-(void)showLoginViewController
{
    [self pushLoginViewController];
}

-(void)pushLoginViewController
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIViewController *controller = (UIViewController *)[[delegate window] rootViewController];
   // [rootNav pushViewController:self animated:YES];
    SNNavigationController *nav = [[SNNavigationController alloc] initWithRootViewController:self];
    [nav setNavBarBgWithColor:[UIColor clearColor]];
    [controller presentViewController:nav animated:YES completion:nil];
}

#pragma --mark sign in butto clicked
-(void)signInButtonClicked:(UIButton *)button
{
    CSSignInViewController * controller = [[CSSignInViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma -mark login button clicked 登录
-(void)loginButtonClicked:(id)sender
{
    
    
//    if (isPressCodeButton == NO) {
//        [self.view showMessageHud:@"请获取验证码"];
//        return;
//    }
    
    NSString* userNameText = [self.userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* codeText = [self.codeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.view showMessageHud:@"加载中..."];

    if (userNameText.length <= 0 ) {
        [self.view showMessageHud:@"用户名错误，请重新输入"];
        return;
    }
    if (codeText == nil ) {
        [self.view showMessageHud:@"请输入密码"];
        return;
    }

    [[SAUserInforManager shareManager] login:userNameText code:codeText];
    [[SAUserInforManager shareManager] misLogin:@"GDWS2016" code:@"e10adc3949ba59abbe56e057f20f883e"];
    
    
}

#pragma -mark getcode button clicked
//获取验证码
-(void)getCodeButtonClicked:(id)sender
{
    NSString* userName = _userNameField.text;
    NSString* msg = [self valiMobile:userName];
    if (msg != nil) {
        [self.view showMessageHud:msg delaySecondsForHide:1.0];
        return;
    }
    //启动倒计时
//    [self startTime];
    __weak typeof(self) weakSelf = self;
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager postPhoneCode:userName CallBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            NSLog(@"getcode%@",dicData);
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                [weakSelf.view showMessageHud:@"获取验证码成功"];
            }
            else
            {
                NSString *errorMessage = @"获取验证码失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                [weakSelf.view showMessageHud:errorMessage];
            }
        }
        else
        {
            NSString *errorMessage = @"获取验证码失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}

#pragma -mark UIGestureRecognizer delegate
-(void)selfTapped:(UIGestureRecognizer*)recognizer
{
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(touch.view == self.userNameField){
             [self.userNameField becomeFirstResponder];
        [self.codeField resignFirstResponder];
    }else if(touch.view == self.codeField){
             [self.codeField becomeFirstResponder];
        [self.userNameField resignFirstResponder];
    }else{
               [self.codeField resignFirstResponder];
        [self.userNameField resignFirstResponder];
    }
    
    return YES;
}

#pragma -mark UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIButton* clearButton = nil;
    
    if (textField == self.userNameField) {
        clearButton = self.clearUserNameButton;
    } else if (textField == self.codeField) {
        clearButton = self.clearcodeButton;
    }
    
    if (clearButton == nil) {
        return;
    }
    
    if (textField.text.length <= 0) {
        clearButton.hidden = YES;
    } else {
        clearButton.hidden = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)userNameTextFieldChanged:(id)sender
{
    NSString* text = self.userNameField.text;
    
    if (text.length <= 0) {
        self.clearUserNameButton.hidden = YES;
    }else{
        self.clearUserNameButton.hidden = NO;
    }
}

- (void)codeTextFieldChanged:(id)sender
{
    NSString* text = self.codeField.text;
    
    if (text.length <= 0) {
        self.clearcodeButton.hidden = YES;
    }else{
        self.clearcodeButton.hidden = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - clearButtonClicked
-(void)clearUserNameButtonClicked:(id)sender
{
    self.userNameField.text = @"";
    self.clearUserNameButton.hidden = YES;
}

-(void)clearcodeButtonClicked:(id)sender
{
    self.codeField.text = @"";
    self.clearcodeButton.hidden = YES;
}

////微信登录
//-(void)weixinLogin:(UIButton *)button
//{
//    [[SAUserInforManager shareManager] thirdLoginWithType:@"weixin"];
//}
//
////qq登录
//-(void)qqLogin:(UIButton *)button
//{
//    [[SAUserInforManager shareManager] thirdLoginWithType:@"qq"];
//}

//判定手机号是否合法
- (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length != 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的手机号码";
        }
    }
    // return nil;
}

////倒计时
//-(void)startTime{
//    __block int timeout=60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<=0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//
//                _countDownLabel.hidden = YES;
//                _getCode.userInteractionEnabled = YES;
//            });
//        }else{
//            int seconds = timeout % 100;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//        
//                [_getCode setTitle:@"已发送验证码" forState:UIControlStateNormal];
//                [_getCode sizeToFit];
//                isPressCodeButton = YES;
//                _countDownLabel.hidden = NO;
//                _countDownLabel.text = strTime;
//                [UIView commitAnimations];
//                _getCode.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//}

@end
