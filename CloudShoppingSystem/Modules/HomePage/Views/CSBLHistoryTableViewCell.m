//
//  CSBLHistoryTableViewCell.m
//  CloudShoppingSystem
//
//  Created by Living on 2017/7/11.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLHistoryTableViewCell.h"

@implementation CSBLHistoryTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self = [[[NSBundle mainBundle] loadNibNamed:@"CSBLHistoryTableViewCell" owner:self options:nil] firstObject];
        self.separatorInset = UIEdgeInsetsMake(0, 600, 0, 0);
        self.eventBtn.userInteractionEnabled = NO;
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)setBaseContent:(CSBackLogDetailBaseModel *)item {
   
    
    DebugLog(@"baseItem----%@",item);
    
   
    NSString *btnTitle = [self obtainTypeStr:item.type];
    self.eventBtn.titleLabel.text = btnTitle;
    
    
}

-(void)setMedContent:(CSBackLogDetailMedModel *)item {
    
    NSString *btnTitle = [self obtainTypeStr:item.type];
    self.eventBtn.titleLabel.text = btnTitle;
    
    
}





+(NSString *)cellIdentifier
{
    return @"CSBLHistoryTableViewCellID";
}

+(CGFloat)cellHeight
{
    return 44 * SA_SCREEN_SCALE;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.eventBtn.layer.cornerRadius = self.eventBtn.frame.size.width / 2.0;
    self.eventBtn.layer.masksToBounds = YES;
}

- (NSString *)obtainTypeStr:(NSString *)type {
    
    if ([type  isEqual: @"0"]) {
        return @"分发";
    }else if ([type  isEqual: @"1"]) {
        return @"处理";
    }else if ([type  isEqual: @"2"]) {
        return @"转移";
    }else {
        return @"完成";
    }
        
}

@end
