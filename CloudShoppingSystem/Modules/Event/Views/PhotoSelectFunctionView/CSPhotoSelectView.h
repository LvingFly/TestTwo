//
//  CSPhotoSelectView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSPhotoSelectViewDelegate <NSObject>

-(void)photoSelectViewItem:(NSInteger)index;

@end

@interface CSPhotoSelectView : UIView

@property (nonatomic, weak) id<CSPhotoSelectViewDelegate>delegate;

@end
