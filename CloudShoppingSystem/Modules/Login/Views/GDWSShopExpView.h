//
//  GDWSShopExpView.h
//  Mall_GDWS
//
//  Created by Dengyuchi on 16/6/8.
//  Copyright © 2016年 GaoDeWeiSi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    EUserShopExpType,
    EUserFamailiarBrandsType,
}UserPreferenceSelectType;

@protocol GDWSShopExpViewDelegate <NSObject>

-(void)resetButtonClicked;
-(void)moreBrandsButtonClicked;
-(void)didSelectNodeAtIndex:(NSInteger)index;
-(void)didDeSelectNodeAtIndex:(NSInteger)index;

@end

@interface GDWSShopExpView : UIView

@property(nonatomic)UserPreferenceSelectType selectType;
@property(nonatomic, strong)NSArray *typeArray;
@property(nonatomic, weak)id<GDWSShopExpViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame withType:(UserPreferenceSelectType)type;
-(void)setTypeArray:(NSArray *)typeArray withSelectArray:(NSArray *)selectArray;

@end
