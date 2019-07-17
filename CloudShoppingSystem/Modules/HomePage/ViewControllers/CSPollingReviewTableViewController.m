//
//  CSPollingReviewTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//巡检查看
#import "CSPollingReviewTableViewController.h"
#import "CSBLDetailSegmentView.h"
#import "CSHistoryPollingView.h"
#import "CSRealTimePollingView.h"

@interface CSPollingReviewTableViewController ()<CCSBLDetailSegmentViewDelegate>

@property(nonatomic, strong)CSBLDetailSegmentView       *segmentView;
@property(nonatomic, strong)UIScrollView                *scrollView;
@property(nonatomic, strong)NSArray                     *scrollSubViewArray;
@property(nonatomic, strong)CSRealTimePollingView       *realTimePollingView;       //实时巡检
@property(nonatomic, strong)CSHistoryPollingView        *historyPollingView;        //历史巡检

@end

@implementation CSPollingReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollSubViewArray = [NSArray arrayWithObjects:self.realTimePollingView,self.historyPollingView, nil];
    [self initSubView];
    [self addScrollSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"巡检" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

-(void)initSubView
{
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollView];
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.mas_equalTo(SA_NAVBAR_HEIGHT_WITH_STATUS_BAR);
        make.height.mas_equalTo(60 * SA_SCREEN_SCALE);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segmentView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
}

-(void)addScrollSubViews
{
    [self.scrollView setContentSize:CGSizeMake(self.scrollSubViewArray.count * SA_SCREEN_WIDTH, self.scrollView.height)];
    
    __block UIView *tempView = nil;
    [self.scrollSubViewArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = (UIView *)obj;
        [self.scrollView addSubview:view];
        
        if (tempView == nil) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.height.top.mas_equalTo(self.scrollView);
            }];
            tempView = view;
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.top.mas_equalTo(tempView);
                make.left.mas_equalTo(tempView.mas_right);
            }];
            tempView = view;
        }
    }];
}

#pragma --mark CPSettingSegementViewDelegate
-(void)didSelectButtonAtIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(SA_SCREEN_WIDTH * index,0) animated:NO];
}

#pragma --mark 懒加载
-(CSBLDetailSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = ({
            CSBLDetailSegmentView *view = [[CSBLDetailSegmentView alloc]initWithFrame:CGRectZero AndItemsArr:@[@"实时巡检",@"历史巡检"]];
            view.backgroundColor = [UIColor clearColor];
            view.delegate = self;
            view;
        });
    }
    return _segmentView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView *view = [[UIScrollView alloc]init];
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view;
        });
    }
    return _scrollView;
}

-(CSRealTimePollingView *)realTimePollingView
{
    if (!_realTimePollingView) {
        _realTimePollingView = ({
            CSRealTimePollingView *view = [[CSRealTimePollingView alloc]initWithFrame:CGRectZero];
            view;
        });
    }
    return _realTimePollingView;
}

-(CSHistoryPollingView *)historyPollingView
{
    if (!_historyPollingView) {
        _historyPollingView = ({
            CSHistoryPollingView *view = [[CSHistoryPollingView alloc]initWithFrame:CGRectZero];
            view;
        });
    }
    return _historyPollingView;
}

@end
