//
//  SAAnimateTabbarView.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SAAnimateTabbarView.h"

enum barsize{
    tabitem_width=80,
    tabitem_hight=SA_TABBAR_HEIGHT,
    tab_hight=SA_TABBAR_HEIGHT,
    tab_width=320,
    other_offtop=0,
    
    img_hight=30,
    img_width=30,
    img_x=45,
    img_y=8
    
};

#define KTabItemNumber 4

@interface SAAnimateTabbarView ()
{
    NSInteger g_selectedTag;
}

@property(nonatomic,strong) UIButton *firstBtn;
@property(nonatomic,strong) UIButton *secondBtn;
@property(nonatomic,strong) UIButton *thirdBtn;
@property(nonatomic,strong) UIButton *fourthBtn;

@end

#define KTabBarFontNormalColor SA_Color_HexString(0x727272, 1)
#define KTabBarFontSelectedColor SA_Color_HexString(0x46a0fc, 1)

@implementation SAAnimateTabbarView

- (id)initWithFrame:(CGRect)frame
{
    g_selectedTag = 10001;
    
    CGRect frame1=CGRectMake(frame.origin.x, frame.size.height-tab_hight, SA_SCREEN_WIDTH, tab_hight);
    
    self = [super initWithFrame:frame1];
    
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
//        float tabItemWidth = SA_SCREEN_WIDTH / KTabItemNumber;
        float tabItemWidth = SA_SCREEN_WIDTH / 3.0;
        _firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tabItemWidth, self.height)];
        _firstBtn.backgroundColor = [UIColor clearColor];
        _firstBtn.titleLabel.font = SA_FontPingFangRegularWithSize(12);
        [_firstBtn setTitle:@"主页" forState:UIControlStateNormal];
        [_firstBtn setTitleColor:KTabBarFontNormalColor forState:UIControlStateNormal];
         [_firstBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateHighlighted];
         [_firstBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateSelected];
        [_firstBtn setImage:[UIImage imageNamed:@"tab_homePageOff"] forState:UIControlStateNormal];
        [_firstBtn setImage:[UIImage imageNamed:@"tab_homePageOn"] forState:UIControlStateHighlighted];
        [_firstBtn setImage:[UIImage imageNamed:@"tab_homePageOn"] forState:UIControlStateSelected];
        _firstBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-_firstBtn.imageView.width,-_firstBtn.imageView.height, 0);
        _firstBtn.imageEdgeInsets = UIEdgeInsetsMake(-_firstBtn.titleLabel.height, 0 , 0, -_firstBtn.titleLabel.width);
        [_firstBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_firstBtn setTag:10001];
        _firstBtn.selected = YES;
        [self addSubview:_firstBtn];
        
//        _secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabItemWidth, 0, tabItemWidth, self.height)];
//        _secondBtn.backgroundColor = [UIColor clearColor];
//        _secondBtn.titleLabel.font = SA_FontPingFangRegularWithSize(12);
//        [_secondBtn setTitle:@"通讯" forState:UIControlStateNormal];
//        [_secondBtn setTitleColor:KTabBarFontNormalColor forState:UIControlStateNormal];
//        [_secondBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateHighlighted];
//        [_secondBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateSelected];
        
//        [_secondBtn setImage:[UIImage imageNamed:@"tab_contactsOff"] forState:UIControlStateNormal];
//        [_secondBtn setImage:[UIImage imageNamed:@"tab_contactsOn"] forState:UIControlStateHighlighted];
//          [_secondBtn setImage:[UIImage imageNamed:@"tab_contactsOn"] forState:UIControlStateSelected];
//        _secondBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_secondBtn.imageView.width, -_secondBtn.imageView.height, 0);
//        _secondBtn.imageEdgeInsets = UIEdgeInsetsMake(-_secondBtn.titleLabel.height,0, 0,-_secondBtn.titleLabel.width);
//        [_secondBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_secondBtn setTag:10002];
//        [self addSubview:_secondBtn];
        
        _thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabItemWidth, 0, tabItemWidth, self.height)];
        _thirdBtn.backgroundColor = [UIColor clearColor];
        _thirdBtn.titleLabel.font = SA_FontPingFangRegularWithSize(12);
        [_thirdBtn setTitle:@"事件" forState:UIControlStateNormal];
        [_thirdBtn setTitleColor:KTabBarFontNormalColor forState:UIControlStateNormal];
        [_thirdBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateHighlighted];
        [_thirdBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateSelected];
        [_thirdBtn setImage:[UIImage imageNamed:@"tab_eventOff"] forState:UIControlStateNormal];
        [_thirdBtn setImage:[UIImage imageNamed:@"tab_eventOn"] forState:UIControlStateHighlighted];
                [_thirdBtn setImage:[UIImage imageNamed:@"tab_eventOn"] forState:UIControlStateSelected];
        _thirdBtn.titleEdgeInsets = UIEdgeInsetsMake(0,-_thirdBtn.imageView.width, -_thirdBtn.imageView.height,0);
        _thirdBtn.imageEdgeInsets = UIEdgeInsetsMake(-_thirdBtn.titleLabel.height,0, 0, -_thirdBtn.titleLabel.width);
        [_thirdBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_thirdBtn setTag:10003];
        [self addSubview:_thirdBtn];
        
        _fourthBtn = [[UIButton alloc] initWithFrame:CGRectMake(tabItemWidth*2, 0, tabItemWidth, self.height)];
        _fourthBtn.backgroundColor = [UIColor clearColor];
        _fourthBtn.titleLabel.font = SA_FontPingFangRegularWithSize(12);
        [_fourthBtn setTitle:@"个人" forState:UIControlStateNormal];
        [_fourthBtn setTitleColor:KTabBarFontNormalColor forState:UIControlStateNormal];
        [_fourthBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateHighlighted];
        [_fourthBtn setTitleColor:KTabBarFontSelectedColor forState:UIControlStateSelected];
        [_fourthBtn setImage:[UIImage imageNamed:@"tab_mineOff"] forState:UIControlStateNormal];
        [_fourthBtn setImage:[UIImage imageNamed:@"tab_mineOn"] forState:UIControlStateHighlighted];
        [_fourthBtn setImage:[UIImage imageNamed:@"tab_mineOn"] forState:UIControlStateSelected];
        _fourthBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_fourthBtn.imageView.width, -_fourthBtn.imageView.height, 0);
        _fourthBtn.imageEdgeInsets = UIEdgeInsetsMake(-_fourthBtn.titleLabel.height, 0, 0,-_fourthBtn.titleLabel.width);
        [_fourthBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_fourthBtn setTag:10004];
        [self addSubview:_fourthBtn];
    }
    return self;
}

-(void)callButtonAction:(UIButton *)sender{
    NSInteger value=sender.tag;
    UITabBarController *tabBarCV = (UITabBarController *)self.window.rootViewController;

    for (UIViewController *vc in tabBarCV.childViewControllers) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            tabBarCV = (UITabBarController *)vc;
        }
    }
    
    if (value==10001) {
        [tabBarCV setSelectedIndex:0];
    }
//    else if (value==10002) {
//        [tabBarCV setSelectedIndex:1];
//    }
    else if (value==10003) {
        [tabBarCV setSelectedIndex:1];
    }
    else if (value==10004){
        [tabBarCV setSelectedIndex:2];
    }
}

//移动tabbar（1-5）
-(void)moveToTabbarIndex:(NSInteger)index{
    UIButton *selectBtn;
    if (index == 0) {
        selectBtn = _firstBtn;
    }
    else if (index == 1){
        selectBtn = _secondBtn;
    }
    else if (index == 2){
        selectBtn = _thirdBtn;
    }else if (index == 3)
    {
        selectBtn = _fourthBtn;
    }
    
    [self buttonClickAction:selectBtn];
}

-(void)buttonClickAction:(id)sender{
    UIButton *btn=(UIButton *)sender;
    if(g_selectedTag==btn.tag)
        return;
    else
        g_selectedTag=btn.tag;
    
    _firstBtn.selected = NO;
    _thirdBtn.selected = NO;
    _secondBtn.selected = NO;
    _fourthBtn.selected = NO;
    btn.selected = YES;
    
    [self moveShadeBtn:btn];
    //[self imgAnimate:btn];
    [self callButtonAction:btn];
    
    return;
}

- (void)moveShadeBtn:(UIButton*)btn{
    
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
     } completion:^(BOOL finished){//do other thing
     }];
}

//- (void)imgAnimate:(UIButton*)btn{
//    
//    [btn.imageView.layer removeAllAnimations];
//    CAKeyframeAnimation * animation;
//    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation.duration = 0.35;
//    animation.delegate = self;
//    animation.removedOnCompletion = YES;
//    animation.fillMode = kCAFillModeForwards;
//    NSMutableArray *values = [NSMutableArray array];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
//    animation.values = values;
//    [btn.imageView.layer addAnimation:animation forKey:nil];
//}

@end
