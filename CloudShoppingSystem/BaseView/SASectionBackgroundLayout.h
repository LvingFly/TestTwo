//
//  SFCCollectionViewSectionBgView.h
//  SinaFreshCity
//
//  Created by 飞 光普 on 14-12-25.
//  Copyright (c) 2014年 sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SASectionBackgroundLayout : UICollectionViewFlowLayout
@property (assign, nonatomic) BOOL alternateBackgrounds;
@property (strong, nonatomic) NSArray *decorationViewOfKinds;
@end
