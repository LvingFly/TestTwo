//
//  CSBLEnclosureView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLEnclosureView.h"
#import "CSBLEnclosureTableViewCell.h"

@interface CSBLEnclosureView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation CSBLEnclosureView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView
{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CSBLEnclosureTableViewCell cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSBLEnclosureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLEnclosureTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSBLEnclosureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLEnclosureTableViewCell cellIdentifier]];
    }
    return cell;
}

#pragma --mark 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            view.delegate = self;
            view.dataSource = self;
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            view.backgroundColor = [UIColor whiteColor];
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view;
        });
    }
    return _tableView;
}

@end
