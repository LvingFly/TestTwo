//
//  CSSelectorPickView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CSSelectorPickViewDelegate <NSObject>


-(void)pickViewSelectItem:(NSString *)item;


-(void)pickViewSelectItem:(NSString *)item WithSelectString:(NSString *)selectID;






@end

@interface CSSelectorPickView : UIView

@property(nonatomic, weak)id<CSSelectorPickViewDelegate> delegate;
@property(nonatomic,copy)void(^block)(NSString *disacount);
- (instancetype)initWithDataArray:(NSArray *)dataArra;


- (instancetype)initWithDataArray:(NSArray *)dataArra WithSelectID:(NSString *)selectID;

@end
