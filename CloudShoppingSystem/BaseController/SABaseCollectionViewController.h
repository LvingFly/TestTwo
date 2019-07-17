//
//  SABaseCollectionViewController.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import "SARefreshViewController.h"
#import "SACollectionViewLayyout.h"


//门店服务页面cell
#define KShopServeCell @"ShopServeCell"
#define KShopServeHeaderView @"ShopServeHeaderView"

//统计查询页面cell
#define KStatQueryHeaderView @"StatQueryHeaderView"
#define KOfQueryCell @"OfQueryCell"
#define KPurchaseQueryCell @"PurchaseQueryCell"
#define KOfStatCell @"OfStatCell"
#define KPofStatView @"PofStatFooterView"
#define KOrderStatCell @"OrderStatCell"
#define KOfStatHeaderView @"OfStatHeaderView"
#define KPofStatClassCell @"PofStatClassCell"
#define KPofStatHeaderView @"PofStatHeaderView"
#define KPurchaseStatCell @"PurchaseStatCell"


@interface SABaseCollectionViewController : SARefreshViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, retain)UICollectionView* collectionView;
@property(nonatomic, retain)SACollectionViewLayyout*layout;
@end
