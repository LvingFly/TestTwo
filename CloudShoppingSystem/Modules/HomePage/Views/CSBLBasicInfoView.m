//
//  CSBLBasicInfoView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/16.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSBLBasicInfoView.h"
#import "CSBLInfoNormalTableViewCell.h"
#import "CSBLInfoOneItemTableViewCell.h"
#import "CSBLInfoSelectTableViewCell.h"
#import "CSBLHistoryTableViewCell.h"
#import "CSSelectPickerView.h"

#import "CSBackLogDetailBaseModel.h"
#import "CSBackLogDetailLastModel.h"
#import "CSBackLogDetailMedModel.h"
#import "CSBLBasicInfoFooterView.h"
#import "CSEventClassModel.h"

@interface CSBLBasicInfoView ()<UITableViewDelegate,UITableViewDataSource,CSBLInfoSelectTableViewCellDelegate,UITextViewDelegate,CSBLBasicInfoFooterViewDelegate>

@property(nonatomic, strong)UITableView                                     *tableView;
@property(nonatomic, strong)NSArray                                            *section1TitleArray;        //第一个section的标题数组
@property(nonatomic, strong)NSArray                                            *section2TitleArray;        //第二个section的标题数组
@property(nonatomic, strong)UITextView                                       *remarkTextView;            //备注信息填写
@property(nonatomic, strong)UIButton                                            *comfirmButton;             //确定
@property(nonatomic, strong)UILabel                                             *placeholderLabel;          //textview 的placeholder
@property(nonatomic, strong)NSMutableArray                               *baseArray;
@property(nonatomic, strong)NSMutableArray                               *lastArray;
@property(nonatomic, strong)NSMutableArray                               *medArray;
@property(nonatomic, strong)CSBackLogDetailBaseModel            *baseItem;
@property(nonatomic, strong)CSBackLogDetailLastModel             *lastItem;
@property(nonatomic, strong)CSBLBasicInfoFooterView               *inFoFooterView;

@property(nonatomic, strong)NSMutableArray                               *departmentArray;

@property (nonatomic, strong) NSString                      *event_Id;
@property (nonatomic, strong) NSString                      *user_type_id;
@end

@implementation CSBLBasicInfoView

-(instancetype)initWithFrame:(CGRect)frame withEventId:(NSString *)eventId
{
    self = [super initWithFrame:frame];
    if (self) {
        self.section1TitleArray = @[@[@"事件编码"],@[@"事件名称",@"事件分类"],@[@"事件地点",@"相关部门"],@[@"上报时间",@"事件类型"],@[@"事件分法人"]];
        self.section2TitleArray = @[@"处理部门",@"事件状态",@"处理人",@"处理时间"];
 
        DebugLog(@"%@",eventId);
        [[NSUserDefaults standardUserDefaults] setObject:eventId forKey:@"eventId"];
        self.event_Id = eventId;
        self.baseArray = [[NSMutableArray alloc] init];
        self.medArray = [[NSMutableArray alloc] init];
        self.lastArray = [[NSMutableArray alloc] init];
        self.departmentArray = [[NSMutableArray alloc] init];
       
        [self getData];
        
        [self initSubView];
    }
    return self;
}

- (void)getData {
    [self initData];
    [self obtainManage];
}
- (void)initData {
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    __weak typeof(self) weakSelf = self;
    [weakSelf.superview showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager getUntreatedEvent:userID eventId:self.event_Id callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSDictionary *dic = [dec mj_JSONObject];
                DebugLog(@"%@",dic);
                NSDictionary *baseDic = [dic validValueForKey:@"base"];
                CSBackLogDetailBaseModel *baseModel = [[CSBackLogDetailBaseModel alloc] initWithDictionary:baseDic];
                self.baseItem = baseModel;
                //存入处理人ID
                [[NSUserDefaults standardUserDefaults] setObject:baseModel.add_uid forKey:@"inputUserId"];
                DebugLog(@"%@",baseModel);
                
                NSDictionary *lastDic = [dic validValueForKey:@"last"];
                if ([lastDic isKindOfClass:[NSDictionary class]] && lastDic != nil) {
                    
                    CSBackLogDetailLastModel *lastModel = [[CSBackLogDetailLastModel alloc] initWithDictionary:lastDic];
                    self.lastItem = lastModel;
                    self.user_type_id = lastModel.type;
                    DebugLog(@"%@----%@",baseModel,lastModel);
                    DebugLog(@"处理人状态%@",lastModel.type);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:lastModel.lastId forKey:@"fatherId"];
                    [[NSUserDefaults standardUserDefaults] setObject:lastModel.is_continue forKey:@"is_continue"];

                    
                }else {
                    self.user_type_id = @"0";
                    
                    
                }
                NSArray *medArr = [dic validValueForKey:@"med"];
                if (medArr.count != 0) {
                    for (NSDictionary *medDic in medArr) {
                        CSBackLogDetailMedModel *medItem = [[CSBackLogDetailMedModel alloc] initWithDictionary:medDic];
                        [self.medArray addObject:medItem];
                    }
                }
                [self.tableView reloadData];
            }
        }else{
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.superview showMessageHud:errorMessage];
        }
    }];
    
}

#pragma mark  网络请求
-(void)obtainManage {
    __weak typeof(self) weakSelf = self;
    [weakSelf.superview showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager obtainManageCallBack:^(id resp, NSError *error) {
        if (!error) {
            [self hideHude];
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSArray *arr = [dec mj_JSONObject];
                [_departmentArray removeAllObjects];
                for (NSDictionary *dic in arr) {
                    NSString *manageName = [dic validValueForKey:@"cname"];
                    [_departmentArray addObject:manageName];
                }
            }
            else
            {
                NSString *errorMessage = @"获取信息失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                [weakSelf showMessageHud:errorMessage];
            }
            
        } else {
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf showMessageHud:errorMessage];
        }
    }];
}


-(void)initSubView
{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

-(void)initTableFooterView
{
}
#pragma -mark CSBLBasicInfoFooterViewDelegate
-(void)submitCompleted {
    if ([self.delegate respondsToSelector:@selector(footerViewSubmitCompleted)]) {
        [self.delegate footerViewSubmitCompleted];
    }
    
}



#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 70 * SA_SCREEN_SCALE;
    }else {
        return 44 * SA_SCREEN_SCALE;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 28 * SA_SCREEN_SCALE;
            break;
        case 1:
            return 42 * SA_SCREEN_SCALE;
            break;
        case 2:
            return 42 * SA_SCREEN_SCALE;
            break;
        default:
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 42 * SA_SCREEN_SCALE)];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 28 * SA_SCREEN_SCALE)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#46a0f3"];
    
    UILabel *label =[SAControlFactory createLabel:@"事件基础事件" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0xffffff, 1) textAlignment:NSTextAlignmentLeft lineBreakMode:NSLineBreakByWordWrapping];
    if (section == 0) {
   

    }else
    {
        
    }
    
    switch (section) {
        case 0:
            label.text = @"事件基础信息";
            headerView.height = 28 * SA_SCREEN_SCALE;
            headerView.backgroundColor = [UIColor whiteColor];
            label.top = (bgView.height - label.height)/2 ;
            bgView.top = headerView.top;
            break;
        case 1:
            headerView.height = 42 * SA_SCREEN_SCALE;
            label.text = @"历史处理信息";
            headerView.backgroundColor = KDefaultBackgroundColor;
            label.top = (bgView.height - label.height)/2 ;
            bgView.bottom = headerView.bottom;
            break;
        case 2:
            label.text = @"事件处理信息";
            headerView.height = 28 * SA_SCREEN_SCALE;
            headerView.backgroundColor = [UIColor whiteColor];
            label.top = (bgView.height - label.height)/2 ;
            bgView.top = headerView.top;
            break;
        default:
            break;
    }
    
    [headerView addSubview:bgView];
    [label sizeToFit];
    label.centerX = bgView.centerX;
    [bgView addSubview:label];
    return headerView;
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return self.medArray.count + 1;
            break;
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            NSArray *titleArray = [self.section1TitleArray objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                CSBLInfoOneItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLInfoOneItemTableViewCell cellIdentifier]];
                if (!cell) {
                    cell = [[CSBLInfoOneItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLInfoOneItemTableViewCell cellIdentifier]];
                }
                NSString *titleString = [titleArray firstObject];
                cell.indexPath = indexPath;
                [cell setTitleString:titleString];
                cell.contentLabel.text = self.baseItem.code;
                return cell;
            }else if (indexPath.row == 4)
            {
                CSBLInfoSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLInfoSelectTableViewCell cellIdentifier]];
                if (!cell) {
                    cell = [[CSBLInfoSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLInfoSelectTableViewCell cellIdentifier]];
                }
                cell.delegate = self;
                cell.indexPath = indexPath;
                cell.value1Label.text = self.baseItem.user;
                return cell;
            }else
            {
                CSBLInfoNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLInfoNormalTableViewCell cellIdentifier]];
                if (!cell) {
                    cell = [[CSBLInfoNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLInfoNormalTableViewCell cellIdentifier]];
                }
                switch (indexPath.row) {
                    case 1:
                        cell.value1Label.text = self.baseItem.name;
                        cell.value2Label.text = [self obtainEventType:self.baseItem.status];
                        break;
                    case 2:
                        cell.value1Label.text = self.baseItem.location;
                        cell.value2Label.text = self.baseItem.manage;
                        break;
                    case 3:
                        cell.value1Label.text = self.baseItem.addtime;
                        cell.value2Label.text = self.baseItem.classify;
                        break;
                    default:
                        break;
                }
                cell.indexPath = indexPath;
                [cell setTitle1String:[titleArray objectAtIndex:0] title2String:[titleArray objectAtIndex:1]];
                return cell;
            }
        }
            break;
        case 1:
        {
            
            CSBLHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLHistoryTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSBLHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLHistoryTableViewCell cellIdentifier]];
            }
            if (self.medArray.count > 0) {
                switch (indexPath.row) {
                    case 0: {
                        CSBackLogDetailBaseModel *item = self.baseItem;
                        cell.topLineView.hidden = YES;
                        NSString *tile = [self obtainTypeStr:item.type];
                        [cell.eventBtn setTitle:tile forState:UIControlStateNormal];
                        [cell.timeLabel setText:self.baseItem.addtime];
                        NSString *typeStr = [self obtainEventType:item.type];
                        NSString *contentString = [NSString stringWithFormat:@"已%@,%@,%@,%@,%@,%@,%@",tile,item.user,item.manage,item.name,typeStr,item.classify,item.location];
                        [cell.contentLabel setText:contentString];
                    }
                        break;
                    default: {
                        CSBackLogDetailMedModel *meditem = [[CSBackLogDetailMedModel alloc] init];
                        meditem = self.medArray[indexPath.row-1];
                        NSString *tile = [self obtainTypeStr:meditem.type];
                        [cell.eventBtn setTitle:tile forState:UIControlStateNormal];
                        [cell.timeLabel setText:meditem.addtime];
                        NSString *contentStr = [NSString stringWithFormat:@"已%@,%@,%@",tile,meditem.deal_user,meditem.text];
                        [cell.contentLabel setText:contentStr];
                    }
                        break;
                }
                if (indexPath.row == self.medArray.count && self.medArray.count > 0) {
                    cell.bottomLineView.hidden = YES;
                    [cell.timeLabel setTextColor:[UIColor orangeColor]];
                    [cell.contentLabel setTextColor:[UIColor orangeColor]];
                }
            }
            return cell;
        }
            break;
        case 2:
        {
            NSArray *titleArray = [self.section1TitleArray objectAtIndex:indexPath.row];
            CSBLInfoOneItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSBLInfoOneItemTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSBLInfoOneItemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSBLInfoOneItemTableViewCell cellIdentifier]];
            }
            NSString *titleString = [titleArray firstObject];
            cell.indexPath = indexPath;
            [cell setTitleString:titleString];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark  CSBLBasicInfoFooterViewDelegate
-(void)keyboardAppeared {
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardDisappeared {
    DebugLog(@"键盘消失了");
}

#pragma --mark UITextView delegate

#pragma --mark CSInvestmentDetailSelectTableViweCellDelegate
//选择了那一行的Cell button
-(void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CSSelectPickerView *selectPickerView = [[CSSelectPickerView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT) withDataArray:@[@"1",@"2",@"3",@"4",@"5"]];
    [selectPickerView didSelectItemAtIndex:^(NSInteger index) {
        NSLog(@"选择了第%ld个",index);
    }];
    if (indexPath.section == 0) {
        if (indexPath.row < self.section1TitleArray.count) {
            NSString *titleString = [[self.section1TitleArray objectAtIndex:indexPath.row] firstObject];
            [selectPickerView setTitleString:titleString];
        }
    }else
    {
        if (indexPath.row < self.section2TitleArray.count) {
            NSString *titleString = [self.section2TitleArray objectAtIndex:indexPath.row];
            [selectPickerView setTitleString:titleString];
        }
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:selectPickerView];
}

#pragma mark  自定义方法 返回事件类型汉字
-(NSString *)obtainEventType:(NSString *)type {
    if ([type  isEqual: @"1"]) {
        return @"一般";
    }else if ([type  isEqual: @"2"]) {
        return @"紧急";
    }else if ([type  isEqual: @"3"]) {
        return @"一周";
    }else{
        return @"其他";
    }
}

- (NSString *)obtainTypeStr:(NSString *)type {
    if ([type  isEqual: @"0"]) {
        return @"分发";
    }else if ([type  isEqual: @"1"]) {
        return @"处理";
    }else if ([type  isEqual: @"2"]) {
        return @"转移";
    }else {
        return @"完成";
    }
    
}




#pragma --mark 懒加载
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            view.delegate = self;
            view.dataSource = self;
            view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            view.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            view.backgroundColor = [UIColor clearColor];
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view.tableFooterView = self.inFoFooterView;
            self.remarkTextView = self.inFoFooterView.inputTextView;
            [view registerClass:[CSBLHistoryTableViewCell class] forCellReuseIdentifier:[CSBLHistoryTableViewCell cellIdentifier]];
            view;
        });
    }
    return _tableView;
}

-(UITextView *)remarkTextView
{
    if (!_remarkTextView) {
        _remarkTextView = ({
            UITextView *view = [[UITextView alloc]init];
            view.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
            view.layer.cornerRadius = 10 * SA_SCREEN_SCALE;
            [view setFont:SA_FontPingFangRegularWithSize(14)];
            [view setTextColor:SA_Color_HexString(0x333333, 1)];
            view.layer.borderWidth = 1 * SA_SCREEN_SCALE;
            view.layer.borderColor = SA_Color_HexString(0xcccccc, 1).CGColor;
            view.dataDetectorTypes = UIDataDetectorTypeAll;
            view.delegate = self;
            view;
        });
    }
    return _remarkTextView;
}

-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"如有备注信息，请在框内填写" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(14) textColor:[UIColor colorWithHexString:@"#727272"] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _placeholderLabel;
}

-(UIButton *)comfirmButton
{
    if (!_comfirmButton) {
        _comfirmButton = ({
            UIButton *button = [[UIButton alloc]init];
            [button setTitle:@"确定" forState:UIControlStateNormal];
            [button.titleLabel setFont:SA_FontPingFangRegularWithSize(16)];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setBackgroundColor:[UIColor colorWithHexString:@"#d7d7d7"] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithHexString:@"#34d569"] forState:UIControlStateSelected];
            button;
        });
    }
    return _comfirmButton;
}

- (CSBLBasicInfoFooterView *)inFoFooterView {
    if (!_inFoFooterView) {
        _inFoFooterView = ({
             CSBLBasicInfoFooterView * view = [[CSBLBasicInfoFooterView alloc] initWithDepartmentsArr:self.departmentArray WithUserType:self.user_type_id];
            view.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 344*SA_SCREEN_SCALE);
            view.delegate = self;
            view;
        });
    }
    return _inFoFooterView;
}



#pragma mark -  键盘即将跳出
-(void)didClickKeyboard:(NSNotification *)sender{
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:durition animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -(keyboardHeight));
    }];
}
#pragma mark -      当键盘即将消失
-(void)didKboardDisappear:(NSNotification *)sender{
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}
@end
