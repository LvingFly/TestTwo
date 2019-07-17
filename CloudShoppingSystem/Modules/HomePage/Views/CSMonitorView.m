
//  CSMonitorTowView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/17.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMonitorView.h"

@interface CSMonitorView ()

//@property (nonatomic, strong) UIButton *entryBtn;
@property (nonatomic, strong) ZGLVideoPlyer *player;

@end
@implementation CSMonitorView

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CSMonitorView" owner:self options:nil] lastObject];
        self.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 500);
//        CGFloat deviceWith = [UIScreen mainScreen].bounds.size.width;
        
        [self initSubview];
    }
    return self;
}

- (void)initSubview {

//    [self addSubview:self.entryBtn];
    
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:self.frame];
    self.player.videoUrlStr = @"http://192.168.1.68:8080/mmm/a1.mp4";
    [self addSubview:self.player];
    
    
    [self.player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];
}

-(void)obtainTime {
    NSDate *date = [NSDate date]; // 获得时间对象
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:date];
    DebugLog(@"时间%@",dateStr);
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
    
}


-(void)testTimerDeallo {
    [self obtainTime];
}

- (void)dealloc {
    
    
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    
    
}







@end
