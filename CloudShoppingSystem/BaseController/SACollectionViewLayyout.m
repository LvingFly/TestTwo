//
//  SACollectionViewLayyout.m
//  SuperAssistant
//
//  Created by Daisiyou on 15/6/3.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SACollectionViewLayyout.h"

@implementation SACollectionViewLayyout


//内容区域总大小，不是可见区域
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, (236 + 115 + 6 + 64) * SA_SCREEN_SCALE * [self.collectionView numberOfSections]);
}

//所有单元格位置信息
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
   
    NSMutableArray *array = [NSMutableArray array];
    
    //配置每个item的属性
    for (NSInteger i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        CGFloat cellCount = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j<cellCount; j++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
            [array addObject:attribute];
        }
    }
    
    //配置每个header的属性
    for (NSInteger j = 0; j < [self.collectionView numberOfSections]; j++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:j];
        UICollectionViewLayoutAttributes * attribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [array addObject:attribute];
    }
    
    return array;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    
    attribute.frame = CGRectMake(0, (236 + 115 + 6 + 64) * SA_SCREEN_SCALE * indexPath.section, SA_SCREEN_WIDTH, 64);

    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat itemSpacing = 6;
    CGFloat largeCellWidth = 120.0 * SA_SCREEN_SCALE;
    CGFloat largeCellHeight = 236.0 * SA_SCREEN_SCALE;
    CGFloat smallCellWidth = 174.0 * SA_SCREEN_SCALE;
    CGFloat smallCellHeight = 115.0 * SA_SCREEN_SCALE;
    CGFloat bottomCellWidth = SA_SCREEN_WIDTH -(10 + 10)* SA_SCREEN_SCALE;
    CGFloat bottomCellHeight = 115.0 * SA_SCREEN_SCALE;
    CGFloat headerHeight = SA_NAVBAR_HEIGHT_WITH_STATUS_BAR;

    //右侧单元格x坐标
    CGFloat rightSmallX = self.collectionView.bounds.size.width - smallCellWidth - 10 * SA_SCREEN_SCALE;
    
    //每行4个图片，1行循环一次，一共4种位置
    if (indexPath.item % 4 ==0)
    {
        attribute.frame = CGRectMake(10*SA_SCREEN_SCALE, indexPath.section * (236 + 115 + 6 + 64)*SA_SCREEN_SCALE + headerHeight, largeCellWidth, largeCellHeight);
    }else if(indexPath.item % 4 == 1)
    {
        attribute.frame = CGRectMake(rightSmallX, indexPath.section * (236 + 115 + 6 + 64)*SA_SCREEN_SCALE + headerHeight, smallCellWidth, smallCellHeight);
    }else if(indexPath.item % 4 == 2)
    {
        attribute.frame = CGRectMake(rightSmallX, indexPath.section * (236 + 115 + 6 + 64)*SA_SCREEN_SCALE + headerHeight + smallCellHeight + itemSpacing, smallCellWidth, smallCellHeight);
        
    }else if(indexPath.item % 4 == 3)
    {
        attribute.frame = CGRectMake(10*SA_SCREEN_SCALE, indexPath.section * (236 + 115 + 6 + 64)*SA_SCREEN_SCALE + headerHeight + largeCellHeight + itemSpacing, bottomCellWidth, bottomCellHeight);
    }
    
    return attribute;
}


@end
