//
//  CSSelectPickerView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectItemBlock)(NSInteger index);

@interface CSSelectPickerView : UIView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;

@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, copy)SelectItemBlock selectItemBlock;
-(void)didSelectItemAtIndex:(SelectItemBlock)block;

@end
