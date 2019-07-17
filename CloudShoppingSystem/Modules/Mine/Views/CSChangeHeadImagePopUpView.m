//
//  CSChangeHeadImagePopUpView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
/**
 选择相册或相机弹出的view
 */
#import "CSChangeHeadImagePopUpView.h"

@interface CSChangeHeadImagePopUpView ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong)UIView          *bgView;
@property(nonatomic, strong)UIButton        *photoAlbumButton;
@property(nonatomic, strong)UIButton        *cameraButton;
@property(nonatomic, strong)UIButton        *cancelButton;

@end

@implementation CSChangeHeadImagePopUpView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        //添加手势
        UITapGestureRecognizer *tapDisappear = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disappearSelfTap:)];
        tapDisappear.delegate = self;
        [self addGestureRecognizer:tapDisappear];
    }
    return self;
}

-(void)initSubView
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.photoAlbumButton];
    [self.bgView addSubview:self.cameraButton];
    [self.bgView addSubview:self.cancelButton];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self);
        make.height.mas_equalTo(216 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(SA_SCREEN_HEIGHT);
    }];

    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(35 * SA_SCREEN_SCALE);
        make.top.mas_equalTo(25 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(_bgView);
        make.width.mas_equalTo(219 * SA_SCREEN_SCALE);
    }];
    
    [self.photoAlbumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.mas_equalTo(self.cameraButton);
        make.top.mas_equalTo(self.cameraButton.mas_bottom).offset(14 * SA_SCREEN_SCALE);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.height.mas_equalTo(self.photoAlbumButton);
        make.top.mas_equalTo(self.photoAlbumButton.mas_bottom).offset(28 * SA_SCREEN_SCALE);
    }];
}

//页面出现动画
-(void)scrollToTop
{
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SA_SCREEN_HEIGHT - 216 * SA_SCREEN_SCALE);
        }];
        [self layoutIfNeeded];
    }];
}

//页面消失动画
-(void)scrollToBottom
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(SA_SCREEN_HEIGHT);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma --mark button clicked
-(void)selectHeadImageButtonClicked:(UIButton *)button
{
    [self scrollToBottom];
    if (self.headImageBlock) {
        ESelectHeadImageType type;
        switch (button.tag) {
            case 2000:
                type = ESelectImageCameraType;
                break;
            case 2001:
                type = ESelectImagePhotoAblumType;
                break;
            default:
                break;
        }
        self.headImageBlock(type);
    }
}

-(void)cancelButtonClicked:(UIButton *)button
{
    [self scrollToBottom];
}

//消失本页面事件
-(void)disappearSelfTap:(UITapGestureRecognizer *)tap
{
}

#pragma --mark UIGestureRecognizer delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self) {
        [self scrollToBottom];
    }else
    {
        return NO;
    }
    return YES;
}

#pragma --mark 懒加载
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
            view.layer.cornerRadius = 8 * SA_SCREEN_SCALE;
            view;
        });
    }
    return _bgView;
}

-(UIButton *)cameraButton
{
    if (!_cameraButton) {
        _cameraButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangLightWithSize(16)];
            button.layer.cornerRadius = 6 * SA_SCREEN_SCALE;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithHexString:@"#46a0fc"];
            [button setTitle:@"拍照" forState:UIControlStateNormal];
            button.tag = 2000;
            [button addTarget:self action:@selector(selectHeadImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cameraButton;
}

-(UIButton *)photoAlbumButton
{
    if (!_photoAlbumButton) {
        _photoAlbumButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangLightWithSize(16)];
            button.layer.cornerRadius = 6 * SA_SCREEN_SCALE;
            [button setTitle:@"从相册中选取" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor colorWithHexString:@"#46a0fc"];
            button.tag = 2001;
            [button addTarget:self action:@selector(selectHeadImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _photoAlbumButton;
}

-(UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangLightWithSize(16)];
            button.backgroundColor = [UIColor colorWithHexString:@"#34d569"];
            button.layer.cornerRadius = 6 * SA_SCREEN_SCALE;
            [button addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _cancelButton;
}

@end
