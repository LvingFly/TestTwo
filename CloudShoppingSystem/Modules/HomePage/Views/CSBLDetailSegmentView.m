//
//  CSBLDetailSegmentView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLDetailSegmentView.h"

@interface CSBLDetailSegmentView ()

@property(nonatomic, strong)UIButton *selectedButton;   //当前选中button
@property(nonatomic, strong)NSMutableArray* buttonsArr;

@end

@implementation CSBLDetailSegmentView

-(id)initWithFrame:(CGRect)frame AndItemsArr:(NSArray*)itemArr{
    
    self = [super initWithFrame:frame];
    
    self.buttonsArr = [[NSMutableArray alloc]init];
    
    UIView *tempView = nil;
    
    UIView *spaceOneView = [[UIView alloc]init];
    UIView *spaceTowView = [[UIView alloc]init];
    [self addSubview:spaceOneView];
    [self addSubview:spaceTowView];
    
    for (int i = 0; i < itemArr.count; i++)
    {
        UIButton* button = [[UIButton alloc]init];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
        [button setTitleColor:SA_Color_HexString(0x46a0fc, 1) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor colorWithHexString:@"#46a0fc"] forState:UIControlStateSelected];
        [button setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:itemArr[i] forState:UIControlStateNormal];
        button.layer.borderColor = SA_Color_HexString(0x46a0fc, 1).CGColor;
        button.layer.borderWidth = 1 * SA_SCREEN_SCALE;
        [button sizeToFit];
        button.tag = i;
        [button addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            self.selectedButton = button;
        }
        
        [self.buttonsArr addObject:button];
        if (tempView == nil) {
            [spaceOneView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(spaceTowView);
                make.centerY.equalTo(self);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(button.mas_left);
                make.height.mas_equalTo(self);
            }];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceOneView.mas_right);
                make.height.mas_equalTo(31 * SA_SCREEN_SCALE);
                make.centerY.mas_equalTo(self);
                make.width.mas_equalTo(150 * SA_SCREEN_SCALE);
            }];
            
            tempView = button;
        }else
        {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(tempView.mas_right);
                make.height.width.centerY.mas_equalTo(tempView);
            }];
            tempView = button;
            if (i == itemArr.count - 1) {
                [spaceTowView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self);
                    make.centerY.height.width.mas_equalTo(spaceOneView);
                    make.left.mas_equalTo(tempView.mas_right);
                }];
            }
        }
    }
    return self;
}

-(void)changeButtonTitleAtIndex:(NSInteger)index andTitle:(NSString*)title
{
    UIButton * button = self.buttonsArr[index];
    [button setTitle:title forState:(UIControlStateNormal)];
}

-(void)setSelectedButton:(UIButton *)selectedButton
{
    _selectedButton = selectedButton;
    
    for (UIButton* button in self.buttonsArr) {
        //        [button setTitleColor:[UIColor colorWithHexString:@"#a4aab3"] forState:UIControlStateNormal];
        button.selected = NO;
    }
    _selectedButton.selected = YES;
}

#pragma mark - 点击按钮后的动画，和选择了那个按钮要通知主界面
-(void)clickOn:(UIButton*)btn
{
    
    if (self.selectedButton == btn){
        
    }else{
        self.selectedButton.selected = NO;
        self.selectedButton = btn;
        btn.selected = YES;
        [self.delegate didSelectButtonAtIndex:btn.tag];
    }
}

@end
