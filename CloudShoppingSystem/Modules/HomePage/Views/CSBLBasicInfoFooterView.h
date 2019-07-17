//
//  CSBLBasicInfoFooterView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/12.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSBLBasicInfoFooterViewDelegate <NSObject>

-(void)changeFooterViewHeight:(UIButton *)sender;

-(void)changeFooterViewHeightWithType;
-(void)submitCompleted;
-(void)keyboardAppeared;
-(void)keyboardDisappeared;
@end

@interface CSBLBasicInfoFooterView : UIView

@property (weak, nonatomic) IBOutlet UIButton *yesBtn;//tag值 为1001 在SB中设置
@property (weak, nonatomic) IBOutlet UIButton *noBtn;//tag值 为1000 在SB中设置
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;//选择提交部门按钮
@property (weak, nonatomic) id<CSBLBasicInfoFooterViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *dealBtn;//分发人按钮

@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (nonatomic, strong) NSMutableArray *departmentsArr;
@property(nonatomic, strong)UITextView                                       *inputTextView;            //备注信息填写
@property(nonatomic, strong)UILabel                                             *placeholderLabel;          //textview 的placeholder

@property(nonatomic, strong) NSString                   *userType;



- (instancetype)initWithDepartmentsArr:(NSMutableArray *)senderArr;

- (instancetype)initWithDepartmentsArr:(NSMutableArray *)senderArr WithUserType:(NSString *)userType;









@end
