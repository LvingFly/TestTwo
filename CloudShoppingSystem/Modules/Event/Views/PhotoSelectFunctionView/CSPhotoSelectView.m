//
//  CSPhotoSelectView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSPhotoSelectView.h"
@interface CSPhotoSelectView ()


@property (nonatomic, strong) UIButton *photoBtn;//拍照
@property (nonatomic, strong) UIButton *selectBtn;//选取
@property (nonatomic, strong) UIButton *cancelBtn;//选取


@end
@implementation CSPhotoSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    self.backgroundColor = SA_Color_RgbaValue(126, 126, 126, 0.9);

    [self addSubview:self.cancelBtn];
    [self addSubview:self.selectBtn];
    [self addSubview:self.photoBtn];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(35*SA_SCREEN_SCALE);
        make.width.mas_equalTo(250*SA_SCREEN_SCALE);
        make.bottom.mas_equalTo(self).offset(-15);
    }];
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(35*SA_SCREEN_SCALE);
        make.width.mas_equalTo(250*SA_SCREEN_SCALE);
        
        make.bottom.mas_equalTo(self.cancelBtn.mas_top).offset(-20);
        
    }];
    
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(35*SA_SCREEN_SCALE);
        make.width.mas_equalTo(250*SA_SCREEN_SCALE);
        make.bottom.mas_equalTo(self.selectBtn.mas_top).offset(-10);
        
    }];
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
    
}
-(void)dismiss{
    
    __weak typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.1 animations:^{
        
    }completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        
    }];
}

#pragma mark  Button Event
-(void)buttonClicked:(UIButton *)sender {
    //点击取消按钮 视图从父视图上移走
    if (sender.tag == 1000) {
        [self removeFromSuperview];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(photoSelectViewItem:)]) {
        [self.delegate photoSelectViewItem:sender.tag];
    }
}


#pragma mark  懒加载
- (UIButton *)photoBtn {
    if (!_photoBtn) {
        _photoBtn = ({
            UIButton *button = [SAControlFactory createButton:SA_Color_RgbaValue(255, 162, 0, 1) titleColor:[UIColor whiteColor] labelFont:16 titleString:@"拍照"];
            button.tag = 1002;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _photoBtn;
}

- (UIButton *)selectBtn
{
    if (!_selectBtn) {
        _selectBtn = ({//@"从相册中选取"
            UIButton *button = [SAControlFactory createButton:SA_Color_RgbaValue(255, 162, 0, 1) titleColor:[UIColor whiteColor] labelFont:16 titleString:@"从相册中获取"];
            button.tag = 1001;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _selectBtn;
}



- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = ({
            UIButton *button = [SAControlFactory createButton:SA_Color_RgbaValue(52, 213, 105, 1) titleColor:[UIColor whiteColor] labelFont:16 titleString:@"取消"];
            button.tag = 1000;
            button.layer.cornerRadius = 5;
            button.layer.masksToBounds = YES;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cancelBtn;
}





@end
