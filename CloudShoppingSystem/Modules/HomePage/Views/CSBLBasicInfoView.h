//
//  CSBLBasicInfoView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSBLBasicInfoViewDelegate <NSObject>
-(void)footerViewSubmitCompleted;


@end

@interface CSBLBasicInfoView : UIView


@property (nonatomic, strong) NSDictionary  *blBaseInfoDic;
@property (nonatomic, weak)id<CSBLBasicInfoViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withEventId:(NSString *)eventId;

@end
