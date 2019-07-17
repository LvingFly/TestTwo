//
//  CSEmergencyvCell.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEmergencyvCell.h"

@interface CSEmergencyvCell()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIImageView *peronImage;

@end

@implementation CSEmergencyvCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubview];
    }
    return self;
}

- (void)initSubview {
    [self.contentView addSubview:self.peronImage];
//    [self.contentView addSubview:self.phoneLabel];
    
//    [self.peronImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(self.contentView).mas_offset(10);
//        make.top.mas_offset(self.contentView).mas_offset(10);
//        make.bottom.mas_offset(self.contentView).mas_offset(10);
//        make.width.mas_equalTo(50*SA_SCREEN_SCALE);
//    }];

//    [self.peronImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
}






- (void)setImageStr:(NSString *)imageStr {
    _imageStr = imageStr;
    if (_imageStr) {
        
        self.peronImage.image = [UIImage imageNamed:imageStr];
    }
}

- (void)setPhoneNumbe:(NSString *)phoneNumbe {
    _phoneNumbe = phoneNumbe;
    if (_phoneNumbe) {
        [self.textLabel setText:phoneNumbe];
    }
}


+(CGFloat)cellWidth
{
    return SA_SCREEN_WIDTH;
}

+(NSString *)cellIdentifier
{
    return @"CSEmergencyvCellID";
}


#pragma mark  懒加载
- (UIImageView *)peronImage {
    if (!_peronImage) {
        _peronImage = ({
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 50)];
            image;
        });
    }
    return _peronImage;
}



@end
