//
//  CSBLBasicInfoFooterView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/12.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLBasicInfoFooterView.h"
#import "CSSelectorPickView.h"
#import "CSEventManageModel.h"
#import "CSEventManageUserModel.h"


@interface CSBLBasicInfoFooterView ()<UITextViewDelegate,CSSelectorPickViewDelegate> {
    NSString *is_continue;//是否进行下一步
}
@property (weak, nonatomic) IBOutlet UIView *fitsrView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seconrViewHeight;//提交部门view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstViewHeight;//事件状态view
@property (weak, nonatomic) IBOutlet UIButton *inputBtn;//尾部视图提交按钮

@property (nonatomic, strong) CSSelectorPickView *pickView;
@property (nonatomic, strong) CSSelectorPickView *dealView;
@property (nonatomic, strong) NSString *selectStatus;//分发状态和转移状态标识字符串

@property (nonatomic, strong) NSMutableArray *manageArray;//部门模型数组 包含部门名字和部门编号
@property (nonatomic, strong) NSMutableArray *manageNameArray;//部门名字 数组
@property (nonatomic, strong) NSMutableArray *manageUsersArray;//当前用户所属部门的用户 包含用户名字 用户ID 用户昵称
@property (nonatomic, strong) NSMutableArray *manageUsersNameArray;//当前用户所属部门的用户昵称数组

@property (nonatomic, strong) NSString *selectorType;//
@property (nonatomic, strong) NSString *nextId;//分发处理人的下一个ID
@property (nonatomic, strong) NSString *inputUserId;//在不处理情况下 nextId为提交人ID

@end

@implementation CSBLBasicInfoFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithDepartmentsArr:(NSMutableArray *)senderArr
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CSBLBasicInfoFooterView" owner:self options:nil] firstObject];
        self.departmentsArr = senderArr;
        self.userType = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_DealerType];
        self.manageArray = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_Manages];
        self.manageUsersArray = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_ManageUsers];
        
       
        
        DebugLog(@"部门数组%@",self.manageArray);
        DebugLog(@"人员数组%@",self.manageUsersArray);
        

        [self initSubview];
    }
    return self;
}

- (instancetype)initWithDepartmentsArr:(NSMutableArray *)senderArr WithUserType:(NSString *)userType {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CSBLBasicInfoFooterView" owner:self options:nil] firstObject];
        is_continue = @"1";
        self.departmentsArr = senderArr;
        self.userType = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_DealerType];
        if ([self.userType isEqualToString:@"0"]) {
            self.selectorType = @"1";
        }
        
         NSMutableArray *tempManageArr = (NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_Manages];
        self.manageArray = [NSMutableArray arrayWithArray:tempManageArr];
        NSMutableArray *tempManageUsersArr   =(NSMutableArray*)[[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_ManageUsers];
        self.manageUsersArray = [NSMutableArray arrayWithArray:tempManageUsersArr];
    
        self.manageNameArray = [[NSMutableArray alloc] init];
        self.manageUsersNameArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in self.manageArray) {
            DebugLog(@"%@",dic);
            CSEventManageModel *model = [[CSEventManageModel alloc] initWithDictionary:dic];
            DebugLog(@"%@",model);
            [self.manageNameArray addObject:model.manageName];

        }
        
        
        
        for (NSDictionary *dic in self.manageUsersArray) {
            CSEventManageUserModel *model = [[CSEventManageUserModel alloc] initWithDictionary:dic];
            [self.manageUsersNameArray addObject:model.nickname];
            DebugLog(@"%@",dic);
        }
        
        DebugLog(@"部门名字数组%@",self.manageNameArray);
        DebugLog(@"人员名字数组%@",self.manageUsersNameArray);
        
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    /*
     * 0：分发人 只有处理状态
     * 1：处理人 有分发和转移状态
     * 2 ：转移人 有分发和转移状态
     * 4：关闭状态
     */
    if ([self.userType  isEqual: @"0"]) {
        self.fitsrView.hidden = YES;
        self.firstViewHeight.constant = 0;
    }else if ([self.userType  isEqual: @"5"]) {
        self.secondView.hidden = YES;
        self.seconrViewHeight.constant = 0;
    }else if ([self.userType  isEqual: @"1"] || [self.userType isEqualToString:@"2"]) {
        self.secondView.hidden = YES;
        self.seconrViewHeight.constant = 0;
    }else {
        self.secondView.hidden = YES;
        self.seconrViewHeight.constant = 0;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.selectBtn setTitleColor:SA_Color_RgbaValue(52, 213, 105, 1) forState:UIControlStateNormal];
    [self.dealBtn setTitleColor:SA_Color_RgbaValue(52, 213, 105, 1) forState:UIControlStateNormal];
    [self.inputBtn setBackgroundColor:SA_Color_RgbaValue(52, 213, 105, 1) forState:UIControlStateNormal];
    self.inputBtn.layer.cornerRadius = 2.0;
    self.inputBtn.layer.masksToBounds = YES;
    
    [self addSubview:self.inputTextView];
    [self.inputTextView addSubview:self.placeholderLabel];
    
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.thirdView).mas_offset(8);
        make.right.mas_equalTo(self.thirdView).mas_offset(-8);
        make.top.mas_equalTo(self.thirdView).mas_offset(5);
        make.bottom.mas_equalTo(self.thirdView).mas_offset(5);
    }];
    
    self.placeholderLabel.left = 5 * SA_SCREEN_SCALE;
    self.placeholderLabel.top = 5 * SA_SCREEN_SCALE;
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)action_yesBtn:(UIButton *)sender {
    
    [self.noBtn setImage:[UIImage imageNamed:@"item_contact_normal.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"item_contact_checked.png"] forState:UIControlStateNormal];
    
    is_continue = @"1";
    //selectStatus当前状态 自己判断出来的
    if ([self.selectStatus isEqualToString:@"分发"]) {
        self.selectorType = @"0";
    }
    if ([self.selectStatus isEqualToString:@"转移"]) {
        self.selectorType = @"2";
    }
    DebugLog(@"%@",self.selectStatus);
    
    
#warning 后面可以精简 因为直接将footerHeight高度设定完 不需要改变footerHeight
    if ([self.userType isEqualToString:@"0"]) {
        self.seconrViewHeight.constant = 44;
        self.secondView.hidden = NO;
        self.inputBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        if ([self.delegate respondsToSelector:@selector(changeFooterViewHeight:)]) {
            [self.delegate changeFooterViewHeight:sender];
        }
    
    }else if ([self.userType isEqualToString:@"5"]) {
        self.firstViewHeight.constant = 44;
        self.fitsrView.hidden = NO;
        
        self.seconrViewHeight.constant = 44;
        self.secondView.hidden = NO;
        
    }else if ([self.userType  isEqual: @"1"] || [self.userType isEqualToString:@"2"]) {
    }else {
        self.seconrViewHeight.constant = 44;
        self.secondView.hidden = NO;
        self.inputBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        if ([self.delegate respondsToSelector:@selector(changeFooterViewHeight:)]) {
            [self.delegate changeFooterViewHeight:sender];
        }
    }
    
   
}


- (IBAction)action_noBtn:(UIButton *)sender {
    
    [self.yesBtn setImage:[UIImage imageNamed:@"item_contact_normal.png"] forState:UIControlStateNormal];
    [sender setImage:[UIImage imageNamed:@"item_contact_checked.png"] forState:UIControlStateNormal];
    self.selectorType = @"4";
    is_continue = @"0";
    if ([self.userType isEqualToString:@"0"]) {
        self.seconrViewHeight.constant = 0;
        self.secondView.hidden = YES;
        self.inputBtn.backgroundColor = KNavBarColor;
        if ([self.delegate respondsToSelector:@selector(changeFooterViewHeight:)]) {
            [self.delegate changeFooterViewHeight:sender];
        }
    
    }else if ([self.userType  isEqual: @"1"] || [self.userType isEqualToString:@"2"]) {
        self.firstViewHeight.constant = 0.0;
        self.fitsrView.hidden = YES;
        self.seconrViewHeight.constant = 0;
        self.secondView.hidden = YES;
    
    }else if ([self.userType isEqualToString:@"5"]) {
        self.firstViewHeight.constant = 0.0;
        self.fitsrView.hidden = YES;
        self.seconrViewHeight.constant = 0;
        self.secondView.hidden = YES;
        
    }else {
        self.seconrViewHeight.constant = 0;
        self.secondView.hidden = YES;
        self.inputBtn.backgroundColor = KNavBarColor;
        if ([self.delegate respondsToSelector:@selector(changeFooterViewHeight:)]) {
            [self.delegate changeFooterViewHeight:sender];
        }
    }
    
    
}

#pragma mark  button events
- (IBAction)action_selectBtn:(UIButton *)sender {
    
    
    NSMutableArray *selectArr = [[NSMutableArray alloc] init];
    if ([self.selectStatus isEqualToString:@"分发"]) {
        self.selectorType = @"0";
        selectArr = self.manageUsersNameArray;
    }else if ([self.selectStatus isEqualToString:@"转移"]) {
        self.selectorType = @"1";
        selectArr = self.departmentsArr;
    }else if ([self.selectStatus isEqualToString:@"关闭"]) {
        self.selectorType = @"4";
        selectArr = self.departmentsArr;
    }else if ([self.selectStatus isEqualToString:@"处理"]) {
        self.selectorType = @"2";
        selectArr = self.departmentsArr;
    }else {
        selectArr = self.departmentsArr;
    }
    
    CSSelectorPickView *pick = [[CSSelectorPickView alloc] initWithDataArray:selectArr];
    pick.delegate = self;
    self.pickView = pick;
    [UIView animateWithDuration:0.3 animations:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:pick];
    }];
}

- (IBAction)action_dealBtn:(UIButton *)sender {
    NSArray *arr = [NSArray arrayWithObjects:@"分发",@"转移", nil];
    CSSelectorPickView *pick = [[CSSelectorPickView alloc] initWithDataArray:arr WithSelectID:@"1"];
    pick.delegate = self;
    self.dealView = pick;
    [UIView animateWithDuration:0.3 animations:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:pick];
    }];
}

- (IBAction)action_InputBtn:(UIButton *)sender {
    
    //判断是否为继续处理 点击是为继续处理is_continue为1  点击否为不处理is_continue为0
    if ([is_continue isEqualToString:@"0"]) {
        
    }else {
        if ([self.selectBtn.currentTitle isEqualToString:@"请点击选择提交部门"]) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window showMessageHud:@"请将数据填写完整"];
            return;
        }
    }
    
    NSString *text = self.inputTextView.text;
    NSString *event = [[NSUserDefaults standardUserDefaults] objectForKey:@"eventId"];
    NSString *fid = [[NSUserDefaults standardUserDefaults] objectForKey:@"fatherId"];//上一个人的ID
    NSString *next_id = @"";//分为处理与不处理两种 处理的情况下为下一个人的ID 不处理的情况下为上一个人ID（base里面）
    if ([is_continue  isEqual: @"0"]) {//不继续
        next_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"inputUserId"];
    }else {
        next_id = self.nextId;
    }
    [self.superview showMessageHud:@"加载中"];
    SAHttpNetworkManager *netWorkManager = [SAHttpNetworkManager defaultManager];
    [netWorkManager dealEventWithEventId:event Fid:fid Type:self.selectorType NextId:next_id IsContinue:is_continue Text:text callBack:^(id resp, NSError *error) {
        
        
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
//                NSString *errMsg = [dicData validValueForKey:@"errmsg"];
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                [window showMessageHud:@"提交成功"];
                if ([self.delegate respondsToSelector:@selector(submitCompleted)]) {
                    [self.delegate submitCompleted];
                }
                
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window showMessageHud:errorMessage];
            
        }
    }];
    
    
    
    
    
}


//选择部门或者人
-(void)pickViewSelectItem:(NSString *)item {
    
    
    if ([self.selectStatus isEqualToString:@"分发"]) {
        //分发给人
        for (NSDictionary *dic in self.manageUsersArray) {
            CSEventManageUserModel *model = [[CSEventManageUserModel alloc] initWithDictionary:dic];
            if ([item isEqualToString:model.nickname]) {
                self.nextId = model.userId;
                
                DebugLog(@"%@",self.nextId);
            }
        }
    }else {
        //转移 到部门
        for (NSDictionary *dic in self.manageArray) {
            CSEventManageModel *model = [[CSEventManageModel alloc] initWithDictionary:dic];
            if ([item isEqualToString:model.manageName]) {
                self.nextId = model.manageCode;
                
                DebugLog(@"%@",self.nextId);
            }
        }
    }
    
    
    [self.selectBtn setTitle:item forState:UIControlStateNormal];
}

//选择分发或者转移
-(void)pickViewSelectItem:(NSString *)item WithSelectString:(NSString *)selectID {
    
  
    
    self.selectStatus = item;
    
    self.seconrViewHeight.constant = 44;
    self.secondView.hidden = NO;
    [self.dealBtn setTitle:item forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(changeFooterViewHeightWithType)]) {
        [self.delegate changeFooterViewHeightWithType];
    }
    
}
#pragma mark  懒加载
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"如有备注信息，请在框内填写" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:[UIColor colorWithHexString:@"#727272"] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _placeholderLabel;
}

-(UITextView *)inputTextView
{
    if (!_inputTextView) {
        _inputTextView = ({
            UITextView *view = [[UITextView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            view.layer.cornerRadius = 10 * SA_SCREEN_SCALE;
            [view setFont:SA_FontPingFangRegularWithSize(14)];
            [view setTextColor:SA_Color_HexString(0x333333, 1)];
            view.layer.borderWidth = 1 * SA_SCREEN_SCALE;
            view.layer.borderColor = SA_Color_HexString(0xcccccc, 1).CGColor;
            view.dataDetectorTypes = UIDataDetectorTypeAll;
            view.returnKeyType = UIReturnKeyDone;
            view.delegate = self;
            view;
        });
    }
    return _inputTextView;
}

- (NSMutableArray *)manageArray {
    if (!_manageArray) {
        _manageArray = ({
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            arr;
        });
    }
    return _manageArray;
}


- (NSMutableArray *)manageUsersArray {
    if (!_manageUsersArray) {
        _manageUsersArray = ({
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            arr;
        });
    }
    return _manageUsersArray;
}


//- (NSMutableArray *)manageUsersNameArray {
//    if (!_manageUsersNameArray) {
//        _manageUsersNameArray = ({
//            NSMutableArray *arr = [[NSMutableArray alloc] init];
//            arr;
//        });
//    }
//    return _manageUsersNameArray;
//}


#pragma mark --- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _placeholderLabel.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardAppeared)]) {
        [self.delegate keyboardAppeared];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
if (![textView.text isEqualToString:@""]) {
        _placeholderLabel.hidden = YES;
    }else
    {
        _placeholderLabel.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(keyboardDisappeared)]) {
        [self.delegate keyboardDisappeared];
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

@end
