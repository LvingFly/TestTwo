//
//  SABasePopTableView.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/5/4.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SABasePopListView;

@protocol SAPopListViewDelegate <NSObject>

- (void)onDismissPopListView;

@end

@interface SABasePopListView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, weak)id<SAPopListViewDelegate> delegate;
@property(nonatomic, weak)NSMutableArray* dataSource;
@property(nonatomic, strong)UITableView* tableView;

@end
