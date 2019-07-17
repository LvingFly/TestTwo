//
//  SABaseCollectionViewController.m
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SABaseCollectionViewController.h"
#import "SASectionBackgroundLayout.h"

//#import "SAShopServeCell.h"
//#import "SAShopServeHeaderView.h"

//#import "SAStatQueryHeaderView.h"
//#import "SAOfQueryCell.h"
//#import "SAPurchaseQueryCell.h"
//#import "SAOfStatCell.h"
//#import "SAPofStatView.h"
//#import "SAPurchaseStatCell.h"

//#import "SAOfStatClassCell.h"

//#import "SAPofStatClassCell.h"

//#import "SAOfStatHeaderView.h"
//#import "SAPofStatHeaderView.h"

#import "SACollectionViewLayyout.h"


@interface SABaseCollectionViewController ()

@end

@implementation SABaseCollectionViewController

-(id)init
{
    self = [super init];
    
    if (self) {
        self.type = EBaseCollectionViewController;
    }
    
    return self;
}

- (UICollectionViewFlowLayout *) flowLayout{
    return 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (self.type == EStatQueryViewController) {
//        self.layout = [[SACollectionViewLayyout alloc]init];
//        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT - 64) collectionViewLayout:self.layout];
//        self.collectionView.dataSource = self;
//        self.collectionView.delegate =self;
//    }
    
    //注册cell，
    //请注意：若有多个需要使用collectionView的子View继承自此基类，此处需要分别注册cell类型
//    if (self.type == EShopServeViewController) {
//        [self.collectionView registerClass:[SAShopServeCell class] forCellWithReuseIdentifier:KShopServeCell];
//        [self.collectionView registerClass:[SAShopServeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KShopServeHeaderView];
//    }else if (self.type == EStatQueryViewController) {
//        [self.collectionView registerClass:[SAOfQueryCell class] forCellWithReuseIdentifier:KOfQueryCell];
//        [self.collectionView registerClass:[SAPurchaseQueryCell class] forCellWithReuseIdentifier:KPurchaseQueryCell];
//        [self.collectionView registerClass:[SAOfStatCell class] forCellWithReuseIdentifier:KOfStatCell];
//        [self.collectionView registerClass:[SAPurchaseStatCell class] forCellWithReuseIdentifier:KPurchaseStatCell];
//        
//        [self.collectionView registerClass:[SAStatQueryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KStatQueryHeaderView];
//        
//    }
//    else if (self.type == EOrderStatViewController) {
//        [self.collectionView registerClass:[SAOfStatClassCell class] forCellWithReuseIdentifier:KOrderStatCell];
//        [self.collectionView registerClass:[SAOfStatHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KOfStatHeaderView];
//    }
//    else if (self.type == EPofStatViewController) {
//        [self.collectionView registerClass:[SAPofStatClassCell class] forCellWithReuseIdentifier:KPofStatClassCell];
//        [self.collectionView registerClass:[SAPofStatHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KPofStatHeaderView];
//    }
    
    [self.collectionView setBackgroundColor:KDefaultBackgroundColor];
    [self.collectionView setUserInteractionEnabled:YES];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView setDelegate:self]; //代理－视图
    [self.collectionView setDataSource:self]; //代理－数据
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stopRefreshLoadMore
{
    [self.collectionView.header endRefreshing];
    [self.collectionView.footer endRefreshing];
}


#pragma mark - collectionView delegate
//设置分区
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return 1;
//}
//
////每个分区上的元素个数
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 0;
//}
//
////设置元素内容
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//
////设置元素的的大小框
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    UIEdgeInsets top = {0,0,0,0};
//    return top;
//}
//
////设置顶部的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    CGSize size={0,0};
//    return size;
//}
////设置元素大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(0, 0);
//}
//
////点击元素触发事件
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

@end
