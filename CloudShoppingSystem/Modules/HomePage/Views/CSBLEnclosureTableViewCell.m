//
//  CSBLEnclosureTableViewCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLEnclosureTableViewCell.h"

@interface CSBLEnclosureTableViewCell ()

#warning 该view只是替代填充view，不做具体功能view
@property(nonatomic, strong)UIView      *enclosureView; //附件view

@end

@implementation CSBLEnclosureTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self.contentView addSubview:self.enclosureView];
    [self.enclosureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(300 * SA_SCREEN_SCALE);
        make.height.mas_equalTo(200 * SA_SCREEN_SCALE);
    }];
}

+(NSString *)cellIdentifier
{
    return @"CSBLEnclosureTableViewCellId";
}

+(CGFloat)cellHeight
{
    return 215 * SA_SCREEN_SCALE;
}

#pragma --mark 懒加载
-(UIView *)enclosureView
{
    if (!_enclosureView) {
        _enclosureView = ({
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#46a0f3"];
            view;
        });
    }
    return _enclosureView;
}

@end
