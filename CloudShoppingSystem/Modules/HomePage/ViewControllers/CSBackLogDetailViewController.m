//
//  CSBackLogDetailViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//
//待办事件详情
#import "CSBackLogDetailViewController.h"
#import "CSBLDetailSegmentView.h"
#import "CSBLBasicInfoView.h"
#import "CSBLEnclosureView.h"
#import "CSBackLogDetailBaseModel.h"
#import "CSBackLogDetailLastModel.h"
@interface CSBackLogDetailViewController ()<CCSBLDetailSegmentViewDelegate,CSBLBasicInfoViewDelegate>

@property(nonatomic, strong)CSBLDetailSegmentView       *segmentView;
@property(nonatomic, strong)UIScrollView                *scrollView;
@property(nonatomic, strong)NSArray                     *scrollSubViewArray;
@property(nonatomic, strong)CSBLBasicInfoView           *basicInfoView;
@property(nonatomic, strong)CSBLEnclosureView           *enclosureView;
@property(nonatomic, strong)NSArray                     *section1TitleArray;        //第一个section的标题数组
@property(nonatomic, strong)NSArray                     *section2TitleArray;        //第二个section的标题数组


@end

@implementation CSBackLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self initData];
    self.scrollSubViewArray = [NSArray arrayWithObjects:self.basicInfoView,self.enclosureView, nil];
    
    [self initSubView];
    [self addScrollSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"事件详情" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

- (void)initData {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager getUntreatedEvent:userID eventId:self.eventId callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSDictionary *dic = [dec mj_JSONObject];
                
                DebugLog(@"%@",dic);
                NSDictionary *baseDic = [dic validValueForKey:@"base"];
                
                CSBackLogDetailBaseModel *baseModel = [[CSBackLogDetailBaseModel alloc] initWithDictionary:baseDic];
                NSDictionary *lastDic = [dic validValueForKey:@"last"];
                NSString *userType = @"";
                if ([lastDic isKindOfClass:[NSNull class]] || lastDic == nil) {
                    CSBackLogDetailLastModel *lastModel = [[CSBackLogDetailLastModel alloc] initWithDictionary:lastDic];
                    userType = lastModel.type;
                    DebugLog(@"%@----%@",baseModel,lastModel);
                    DebugLog(@"处理人状态%@",lastModel.type);
                }else {
                    userType = @"0";
                }
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
            
        }
    }];
    
    
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
#pragma --mark CSBLBasicInfoViewDelegate
-(void)footerViewSubmitCompleted {
    [self.navigationController popViewControllerAnimated:YES];
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
            CSBLDetailSegmentView *view = [[CSBLDetailSegmentView alloc]initWithFrame:CGRectZero AndItemsArr:@[@"基础信息",@"事件附件"]];
            view.backgroundColor = [UIColor whiteColor];
            view.delegate = self;
            view;
        });
    }
    return _segmentView;
}

-(CSBLBasicInfoView *)basicInfoView
{
    if (!_basicInfoView) {
        _basicInfoView = ({
            CSBLBasicInfoView *view = [[CSBLBasicInfoView alloc] initWithFrame:CGRectZero withEventId:self.eventId];
            view.delegate = self;
            view;
        });
    }
    return _basicInfoView;
}

-(CSBLEnclosureView *)enclosureView
{
    if (!_enclosureView) {
        _enclosureView = ({
            CSBLEnclosureView *view = [[CSBLEnclosureView alloc]init];
            view;
        });
    }
    return _enclosureView;
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

@end
