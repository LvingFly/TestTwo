//
//  CSMineTableHeaderView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSMineTableHeaderViewDelegate <NSObject>

-(void)headerImageClicked;
-(void)checkInClicked:(UIButton *)sender;


@end

@interface CSMineTableHeaderView : UIView

@property(nonatomic, weak)id<CSMineTableHeaderViewDelegate>delegate;

@end
