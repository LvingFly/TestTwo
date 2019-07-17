//
//  CSDatePickerView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/15.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDateBlock)(NSString *dateString);

@interface CSDatePickerView : UIView

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, copy)SelectDateBlock selectDateBlock;
-(void)didSelectDateAtIndex:(SelectDateBlock)block;
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;

@end
