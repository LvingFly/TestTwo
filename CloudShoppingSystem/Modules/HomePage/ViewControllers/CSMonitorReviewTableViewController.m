//
//  CSMonitorReviewTableViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//监控查看
#import "CSMonitorReviewTableViewController.h"
#import "CSBLDetailSegmentView.h"
#import "CSMonitorView.h"
@interface CSMonitorReviewTableViewController ()<CCSBLDetailSegmentViewDelegate,CSMonitorViewDelegate>

@property(nonatomic, strong)CSBLDetailSegmentView       *segmentView;
#warning 由于这里是视频,所以用scrollview装载两个页面不太妥 时间关系，请后面的人改下
@property(nonatomic, strong)UIScrollView                *scrollView;
@property(nonatomic, strong)NSArray                     *scrollSubViewArray;
@property(nonatomic, strong)CSMonitorView               *monitorOneView;
@property(nonatomic, strong)CSMonitorView               *monitorTowView;

@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *weekDayLabel;

@end

@implementation CSMonitorReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollSubViewArray = [NSArray arrayWithObjects:self.monitorOneView,self.monitorTowView, nil];
    [self initSubView];
    [self addScrollSubViews];
    [self refeshTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"监控查看" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

-(void)initSubView
{
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.weekDayLabel];
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
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scrollView).offset(20);
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.width.mas_equalTo(155*SA_SCREEN_SCALE);
        make.height.mas_equalTo(25*SA_SCREEN_SCALE);
    }];
    [self.weekDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel).offset(155*SA_SCREEN_SCALE);
        make.top.mas_equalTo(self.scrollView.mas_top);
        make.width.mas_equalTo(60*SA_SCREEN_SCALE);
        make.height.mas_equalTo(25*SA_SCREEN_SCALE);
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
- (void)refeshTime {
    static dispatch_source_t _timer;
    NSTimeInterval period = 0.1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self obtainTime];
        });
    });
    dispatch_resume(_timer);
}

#pragma mark  ---CSMonitorViewDelegate
- (void)playBtnClicked {
    
    
}

#pragma --mark CPSettingSegementViewDelegate
-(void)didSelectButtonAtIndex:(NSInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(SA_SCREEN_WIDTH * index,0) animated:NO];
}

#pragma mark  获取时间方法
-(void)obtainTime {
    
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:date];
    NSInteger week;
    NSString *weekStr=nil;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *now = [NSDate date];;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute  | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:now];
    week = [comps weekday];
    if(week==1)
    {
        weekStr=@"星期天";
    }else if(week==2){
        weekStr=@"星期一";
    }else if(week==3){
        weekStr=@"星期二";
    }else if(week==4){
        weekStr=@"星期三";
    }else if(week==5){
        weekStr=@"星期四";
    }else if(week==6){
        weekStr=@"星期五";
    }else if(week==7){
        weekStr=@"星期六";
    }
    else {
        DebugLog(@"error!");
    }
        self.timeLabel.text = dateStr;
        self.weekDayLabel.text = weekStr;
}

#pragma --mark 懒加载
-(CSBLDetailSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = ({
            CSBLDetailSegmentView *view = [[CSBLDetailSegmentView alloc]initWithFrame:CGRectZero AndItemsArr:@[@"画面一",@"画面二"]];
            view.backgroundColor = [UIColor whiteColor];
            view.delegate = self;
            view;
        });
    }
    return _segmentView;
}

-(CSMonitorView *)monitorOneView
{
    if (!_monitorOneView) {
        _monitorOneView = ({
            CSMonitorView *view = [[CSMonitorView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
//            view.mallView.image = [UIImage imageNamed:@"CS_Mall_02.jpg"];
            view.delegate = self;
            view;
        });
    }
    return _monitorOneView;
}

-(CSMonitorView *)monitorTowView
{
    if (!_monitorTowView) {
        _monitorTowView = ({
            CSMonitorView *view = [[CSMonitorView alloc]init];
            view.backgroundColor = [UIColor whiteColor];
//            view.mallView.image = [UIImage imageNamed:@"CS_Mall_03.png"];
            view.delegate = self;
            view;
        });
    }
    return _monitorTowView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = ({
            UIScrollView *view = [[UIScrollView alloc]init];
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view.scrollEnabled = NO;
            view;
        });
    }
    return _scrollView;
    
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"2017-07-07" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _timeLabel;
}


- (UILabel *)weekDayLabel {
    if (!_weekDayLabel) {
        _weekDayLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"星期六" backgroundColor:[UIColor clearColor] font:SA_FontPingFangRegularWithSize(16) textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _weekDayLabel;
}


@end
