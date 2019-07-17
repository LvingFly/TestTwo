//
//  CSMultifunctionTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMultifunctionTableViewCell.h"

@interface CSMultifunctionTableViewCell ()

@property(nonatomic, strong)NSArray         *titleArray;

@end

@implementation CSMultifunctionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.titleArray = @[@"待办事项",@"数据查看",@"招商记录"];
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    UIView *tempView = nil;
    
    //待办事项、数据查看、招商记录 按钮布局
    for (int i = 0; i < _titleArray.count; ++i) {
        UIButton *button = [[UIButton alloc]init];
        NSString *title = [self.titleArray objectAtIndex:i];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mutiFun%d",i + 1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 2017 + i;
        [self.contentView addSubview:button];
        
        UILabel *titleLabel = [SAControlFactory createLabel:title backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
        [button addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button);
            make.bottom.mas_equalTo(button).offset(-10 * SA_SCREEN_SCALE);
        }];
        
        if (tempView == nil) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(13 * SA_SCREEN_SCALE);
                make.width.height.mas_equalTo(button.mas_height);
                make.top.mas_equalTo(10 * SA_SCREEN_SCALE);
                make.bottom.mas_equalTo(self.contentView).offset(-10 * SA_SCREEN_SCALE);
            }];
            tempView = button;
        }else
        {
            if ((i + 1) == self.titleArray.count) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.width.centerY.mas_equalTo(tempView);
                    make.left.mas_equalTo(tempView.mas_right).offset(15 * SA_SCREEN_SCALE);
                    make.right.mas_equalTo(self.contentView).offset(-13 * SA_SCREEN_SCALE);
                }];
            }else
            {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.width.centerY.mas_equalTo(tempView);
                    make.left.mas_equalTo(tempView.mas_right).offset(15 * SA_SCREEN_SCALE);
                }];
            }
            tempView = button;
        }
    }
}

+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"CSMultifunctionTableViewCellId";
}

#pragma --mark button clicked
-(void)selectButtonClicked:(UIButton *)button
{
    NSInteger index = button.tag - 2017;
    if ([self.delegate respondsToSelector:@selector(selectFunctionAtIndex:)]) {
        [self.delegate selectFunctionAtIndex:index];
    }
}

@end
