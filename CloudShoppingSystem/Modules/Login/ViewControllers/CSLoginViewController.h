//
//  WZLoginViewController.h
//  FeiTianDuoBao
//
//  Created by Dengyuchi on 16/3/31.
//  Copyright © 2016年 dengyuchi. All rights reserved.
//

#import "SABaseViewController.h"
@class WZFindPasswordViewController,WZRegisterViewController;

@interface CSLoginViewController : SABaseViewController

+(CSLoginViewController *)shareLoginController;

-(void)showLoginViewController;

-(void)backAction;

@end
