//
//  GDWSShopExpView.m
//  Mall_GDWS
//
//  Created by Dengyuchi on 16/6/8.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import "GDWSShopExpView.h"
#import <SceneKit/SceneKit.h>
#import <SpriteKit/SpriteKit.h>
#import "AnimatedMenuScene.h"
#import "MenuItemNode.h"
#import "GDWSShopExpItem.h"

@interface GDWSShopExpView()<AnimatedMenuSceneDelegate>

@property(nonatomic ,strong)UILabel *guideTitleLabel;
@property(nonatomic ,strong)UILabel *descriptionLabel;
@property(nonatomic ,strong)UIButton *resetButton;
@property(nonatomic ,strong)UIButton * moreButton;

@property (nonatomic, strong)SKView *skView;
@property (nonatomic, strong)AnimatedMenuScene *animatedMenuScene;

@end

@implementation GDWSShopExpView

-(id)initWithFrame:(CGRect)frame withType:(UserPreferenceSelectType)type
{
    self = [super initWithFrame: frame];
    if (self) {
        _selectType = type;
        [self initView];
    }
    return self;
}

-(void)initView
{
//    _typeArray = @[@"咖啡",@"电影",@"聚会",@"服装",@"游乐园",@"滑冰",@"娱乐",@"网吧",@""];
    // Do any additional setup after loading the view, typically from a nib.
    
     __weak typeof(self) weakSelf = self;
    [self addSubview:self.guideTitleLabel];
    [self addSubview:self.descriptionLabel];
    
    [self.guideTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(6 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.guideTitleLabel.mas_bottom).offset(6 * SA_SCREEN_SCALE);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    if (_selectType == EUserShopExpType) {
        
        [self addSubview:self.resetButton];

        [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-80 * SA_SCREEN_SCALE)
            ;
            make.centerX.mas_equalTo(weakSelf.mas_centerX);
            make.width.mas_equalTo(40 * SA_SCREEN_SCALE);
            make.height.mas_equalTo(40 * SA_SCREEN_SCALE);
        }];
    }else
    {
        [self addSubview:self.resetButton];
        [self addSubview:self.moreButton];
        self.guideTitleLabel.text = @"选择您较熟悉的品牌";
        self.descriptionLabel.text = @"请选择至少三个您喜欢的体验类型";
        
        [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.mas_bottom).offset(-80 * SA_SCREEN_SCALE)
            ;
            make.width.mas_equalTo(40 * SA_SCREEN_SCALE);
            make.height.mas_equalTo(45 * SA_SCREEN_SCALE);
            make.left.mas_equalTo(95 * SA_SCREEN_SCALE);
        }];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.centerY.mas_equalTo(weakSelf.resetButton);
            make.width.mas_equalTo(56 * SA_SCREEN_SCALE);
            make.left.mas_equalTo(weakSelf.resetButton.mas_right).offset(95 * SA_SCREEN_SCALE);
        }];
    }
    
    self.skView.frame = CGRectMake(0, 56 * SA_SCREEN_SCALE, SA_SCREEN_WIDTH, 437 * SA_SCREEN_SCALE);
    [self insertSubview:self.skView atIndex:0];
    
    _animatedMenuScene = [[AnimatedMenuScene alloc] initWithSize:self.skView.bounds.size];
    _animatedMenuScene.animatedSceneDelegate = self;// If you want to get notify when an item get selected
    _animatedMenuScene.allowMultipleSelection = YES;
    //_animatedMenuScene.menuNodes = _typeArray;
    _animatedMenuScene.backgroundColor = [UIColor whiteColor];
    [self.skView presentScene:_animatedMenuScene];
}

-(void)setTypeArray:(NSArray *)typeArray withSelectArray:(NSArray *)selectArray
{
    _typeArray = typeArray;
     NSMutableArray *typeArr = [NSMutableArray array];
    NSMutableArray *selectArr = [NSMutableArray array];
    if (_typeArray) {
        for (GDWSShopExpItem *item in _typeArray) {
            [typeArr addObject:item.exName];
        }
    }
    
    if (selectArray) {
        for (GDWSShopExpItem *item in selectArray) {
            [selectArr addObject:item.exName];
        }
    }
    
    [_animatedMenuScene setMenuNodes:typeArr withSelectNodes:selectArr];
}

-(void)setTypeArray:(NSArray *)typeArray
{
     _typeArray = typeArray;
    NSMutableArray *typeArr = [NSMutableArray array];
    if (_typeArray) {
        for (GDWSShopExpItem *item in _typeArray) {
            [typeArr addObject:item.exName];
        }
        [_animatedMenuScene setMenuNodes:typeArr withSelectNodes:nil];
    }
}

#pragma -mark 懒加载
-(UILabel *)guideTitleLabel
{
    if(!_guideTitleLabel)
    {
        _guideTitleLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"选择您喜爱的购物体验" backgroundColor:[UIColor clearColor] font:SA_FontWithSize(24) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _guideTitleLabel;
}

-(UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"请选择至少三个您喜欢的体验类型" backgroundColor:[UIColor clearColor] font:SA_FontWithSize(12) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _descriptionLabel;
}

-(UIButton *)resetButton
{
    if (!_resetButton) {
        _resetButton = ({
            UIButton *button = [[UIButton alloc]init];
           // button.size = CGSizeMake(30 * SA_SCREEN_SCALE, 60 * SA_SCREEN_SCALE);
            button.backgroundColor = [UIColor clearColor];
            [button setImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
            [button setTitle:@"重设" forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontWithSize(14)];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(resetButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
            [button sizeToFit];
            button.titleEdgeInsets = UIEdgeInsetsMake(0,-button.imageView.width,-29 * SA_SCREEN_SCALE, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            button.imageEdgeInsets = UIEdgeInsetsMake(-button.imageView.height - 10 * SA_SCREEN_SCALE,0,0,-button.titleLabel.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            button;
        });
    }
    return _resetButton;
}

-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = ({
            
            UIButton *button = [[UIButton alloc]init];
            // button.size = CGSizeMake(30 * SA_SCREEN_SCALE, 60 * SA_SCREEN_SCALE);
            button.backgroundColor = [UIColor clearColor];
            [button setImage:[UIImage imageNamed:@"morebrands"] forState:UIControlStateNormal];
            [button setTitle:@"更多品牌" forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontWithSize(14)];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button sizeToFit];
            button.titleEdgeInsets = UIEdgeInsetsMake(0,-button.imageView.width,-29 * SA_SCREEN_SCALE, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
            button.imageEdgeInsets = UIEdgeInsetsMake(-button.imageView.height - 10 * SA_SCREEN_SCALE,0,0,-button.titleLabel.width);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            [button addTarget:self action:@selector(moreButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _moreButton;
}

-(SKView *)skView
{
    if (!_skView) {
        _skView = ({
            SKView *view = [[SKView alloc]init];
            view;
        });
    }
    return _skView;
}

#pragma -mark button clicked

-(void)resetButtonCliked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(resetButtonClicked)]) {
        [self.delegate resetButtonClicked];
    }
}

-(void)moreButtonCliked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(moreBrandsButtonClicked)]) {
        [self.delegate moreBrandsButtonClicked];
    }
}

#pragma -mark delegate
#pragma -mark AnimatedMenuSceneDelegate

- (void)animatedMenuScene:(AnimatedMenuScene *)animatedScene didSelectNodeAtIndex:(NSInteger)index {
    NSLog(@"index:%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(didSelectNodeAtIndex:)]) {
        [self.delegate didSelectNodeAtIndex:index];
    }
}

- (void)animatedMenuScene:(AnimatedMenuScene *)animatedScene didDeSelectNodeAtIndex:(NSInteger)index {
    NSLog(@"deselect:%ld",(long)index);
    if ([self.delegate respondsToSelector:@selector(didDeSelectNodeAtIndex:)]) {
        [self.delegate didDeSelectNodeAtIndex:index];
    }
}

@end
