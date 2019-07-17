//
//  CSMonitorTowView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSMonitorViewDelegate <NSObject>

-(void)playBtnClicked;

@end

@interface CSMonitorView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mallView;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic)id<CSMonitorViewDelegate> delegate;


@end
