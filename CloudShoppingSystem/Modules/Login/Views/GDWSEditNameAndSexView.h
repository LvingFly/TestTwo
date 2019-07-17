//
//  GDWSEditNameAndSexView.h
//  Mall_GDWS
//
//  Created by Dengyuchi on 16/6/7.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GDWSEditNameAndSexViewDelegate <NSObject>

-(void)continueClicked;

@end

@interface GDWSEditNameAndSexView : UIView

@property(nonatomic, weak)id<GDWSEditNameAndSexViewDelegate> deleagte;
@property(nonatomic, strong)NSString *userName;

@end
