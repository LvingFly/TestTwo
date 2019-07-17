//
//  SAPopWindowBgView.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/4.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^popBgViewTouchBlock)(void);

//手指触摸此View则整个弹出界面消失
@interface SABasePopBgView : UIView

@property(copy,nonatomic)popBgViewTouchBlock touchBlock ;

@end
