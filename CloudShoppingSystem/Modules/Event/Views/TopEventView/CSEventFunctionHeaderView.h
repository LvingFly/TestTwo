//
//  CSEventFunctionHeaderView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/28.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CSEventFunctionHeaderViewDelegate <NSObject>

-(void)chooseFunctionItem:(NSInteger )itemIndex;
-(void)action_headerViewPhotoAddBtn;

@end

@interface CSEventFunctionHeaderView : UIView
@property(nonatomic, weak)id<CSEventFunctionHeaderViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *headerCollectionView;


@end
