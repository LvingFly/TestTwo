//
//  CSEventViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/3.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventViewController.h"
#import "CSEventFunctionTableViewCell.h"
#import "CSEventFunctionHeaderView.h"
#import "CSEventFunctionFooterView.h"
#import "CSEventFunctionTextCell.h"
#import "CSSelectorPickView.h"
#import "CSEmergencyvViewController.h"
#import "CSPhotoSelectView.h"
#import "HWImagePickerSheet.h"
#import "HWCollectionViewCell.h"
#import "CSEventClassModel.h"
#import "CSEventManageModel.h"

@interface CSEventViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,CSEventFunctionHeaderViewDelegate,CSSelectorPickViewDelegate,CSPhotoSelectViewDelegate,HWImagePickerSheetDelegate,JJPhotoDelegate,HWImagePickerSheetDelegate,CSEventFunctionFooterViewDelegate>
{
    NSMutableArray      *_sumArray;
    NSMutableArray      *_bannerArray;//提交部门
    NSMutableArray      *_departmentArray;//事件分类说明
    NSMutableArray      *_instructionsArray;//选择事件处理紧急状态
    
    NSMutableArray      *_tempLabelArray;//cell末尾请选择label
    NSMutableArray      *_contentLabelArr;//cell中间展示内容的label
    NSIndexPath            *_chooseIndex;//判断选中的哪一行cell
    NSString                  *_inputManageCode;//提交部门编码
    
    NSString *pushImageName;
    //添加图片提示
    UILabel *addImageStrLabel;
}
@property (nonatomic, strong) UITableView *eventTableView;
@property (nonatomic, strong) CSEventFunctionHeaderView *eventHeaderView;
@property (nonatomic, strong) CSEventFunctionFooterView *eventFooterView;
@property (nonatomic, strong) NSMutableArray *eventDataArray;//事件与对应部门数组
@property (nonatomic, strong) NSMutableArray *eventManageArray;//部门名称与对应编编号数组
/*
 * table上的cell的内容
 */
@property (nonatomic, strong) UILabel *departmentLabel;/*提交部门*/
@property (nonatomic, strong) UILabel *instructionLabel;/*事件分类*/
@property (nonatomic, strong) UILabel *eventTypeLabel;/*事件说明*/

@property (nonatomic, strong) UITextField *eventText;/*事件名称*/
@property (nonatomic, strong) UITextField *locationText;/*所在位置*/
@property (nonatomic, strong) NSString *manageCode;/*部门编码*/

#warning 这里通过赋值来刷新界面方法 待定
@property (nonatomic, strong) UILabel *firstCellTempLabel;//第一行cell最后的提示label
@property (nonatomic, strong) UILabel *secondCellTempLabel;//第二行cell最后的提示label
@property (nonatomic, strong) UILabel *thirdCellTempLabel;//第三行cell最后的提示label
@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) CSSelectorPickView *pickView;
@property (nonatomic, strong) HWImagePickerSheet *imgPickerActionSheet;
@property (nonatomic, strong) NSMutableArray *photoJsonArr;
@property (nonatomic, strong) NSString *pathall;
@end

@implementation CSEventViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pathall = @"";
    self.photoJsonArr = [[NSMutableArray alloc] init];
    self.eventManageArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = SA_Color_RgbaValue(242, 242, 242, 1);
    
    [self.eventTableView registerClass:[CSEventFunctionTableViewCell class] forCellReuseIdentifier:[CSEventFunctionTableViewCell cellIdentifier]];
    [self.eventTableView registerClass:[CSEventFunctionTextCell class] forCellReuseIdentifier:[CSEventFunctionTextCell cellIdentifier]];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor clearColor];
    self.maskView = view;
    self.eventDataArray = [[NSMutableArray alloc] init];
    [self initData];
    [self initSubView];
    [self initPickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


/** 初始化collectionView */
-(void)initPickerView{
    _showActionSheetViewController = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [self.eventHeaderView.headerCollectionView setCollectionViewLayout:layout];
    self.pickerCollectionView = self.eventHeaderView.headerCollectionView;
    self.pickerCollectionView.delegate=self;
    self.pickerCollectionView.dataSource=self;
    self.pickerCollectionView.backgroundColor = [UIColor whiteColor];
    
    if(_imageArray.count == 0)
    {
        _imageArray = [NSMutableArray array];
    }
    if(_bigImageArray.count == 0)
    {
        _bigImageArray = [NSMutableArray array];
    }
    pushImageName = @"plus.png";
    
    _pickerCollectionView.scrollEnabled = NO;
    
    //上传图片提示
    addImageStrLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 70, 20)];
    addImageStrLabel.text = @"上传图片";
    addImageStrLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    [self.pickerCollectionView addSubview:addImageStrLabel];
}



-(void)initData{
    _bannerArray = [NSMutableArray arrayWithObjects:@"事件名称",@"提交部门",@"事件分类",@"事件说明",@"所在位置", nil];
    _departmentArray = [NSMutableArray arrayWithObjects:@"总经办",@"推广部",@"运营部",@"财务部009",@"招商部",@"信息部",@"财务部1",@"财务部2",@"财务部3", nil];
    _instructionsArray = [NSMutableArray arrayWithObjects:@"一般事件，请在24小时内处理",@"突发事件，请在2小时内处理",@"常规事件，请在一周之内处理",@"其他", nil];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithObjects:_bannerArray,_departmentArray,_instructionsArray, nil];
    _sumArray = tempArr;
    
    NSMutableArray *labelArr = [NSMutableArray arrayWithObjects:self.departmentLabel,self.instructionLabel,self.eventTypeLabel, nil];
    _contentLabelArr = labelArr;
    
    NSMutableArray *cellTempLabelArray = [NSMutableArray arrayWithObjects:self.firstCellTempLabel,self.secondCellTempLabel,self.thirdCellTempLabel, nil];
    _tempLabelArray = cellTempLabelArray;
    
    [self getManage];//获取所有的事件分类
    [self obtainManage];//获取所有部门的中文名称，部门编码
    
    
}

#pragma mark  父控制器方法
-(void)initNavButtons
{
    UILabel *titleLabel = [SAControlFactory createLabel:@"事件报告" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    resetButton.backgroundColor = [UIColor clearColor];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setTintColor:[UIColor whiteColor]];
    resetButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [resetButton sizeToFit];
    resetButton.right = SA_SCREEN_WIDTH - 5 * SA_SCREEN_SCALE;
    resetButton.top = (SA_SCREEN_HEIGHT - resetButton.height)/2;
    [resetButton addTarget:self action:@selector(resetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:resetButton];
    [self.navigationItem setRightBarButtonItem:rightBarItem];

}


#pragma mark 绘制界面
-(void)initSubView {
    [self.view addSubview:self.eventTableView];
}


#pragma mark  button Events
-(void)resetButtonClicked {
    self.eventText.text = @"";
    self.locationText.text = @"";
    for (UILabel *label in _tempLabelArray) {
        label.hidden = NO;
    }
    for (UILabel *label in _contentLabelArr) {
        label.text = @"";
    }
    self.eventHeaderView.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 125*SA_SCREEN_SCALE);
    self.eventTableView.tableHeaderView = self.eventHeaderView;
    [_imageArray removeAllObjects];
    [_arrSelected removeAllObjects];
    [self.pickerCollectionView reloadData];
}

#pragma mark  网络请求
-(void)getManage {
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager getManagerCallBack:^(id resp, NSError *error) {
        if (!error) {
            [self.view hideHude];
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSArray *arr = [dec mj_JSONObject];
                [_departmentArray removeAllObjects];
                for (NSDictionary *dic in arr) {
                    CSEventClassModel *model = [[CSEventClassModel alloc] initWithDictionary:dic];
                    [_departmentArray addObject:model.name];
                    [self.eventDataArray addObject:model];
                }
            }
            else
            {
                NSString *errorMessage = @"获取信息失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                [weakSelf.view showMessageHud:errorMessage];
            }
        } else {
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}
-(void)obtainManage {
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    [networkManager obtainManageCallBack:^(id resp, NSError *error) { 
        if (!error) {
            [self.view hideHude];
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                NSString *data = [dicData validValueForKey:@"data"];
                NSString *dec = [AESCrypt decrypt:data password:kDefaultKey];
                NSArray *arr = [dec mj_JSONObject];
                [_bannerArray removeAllObjects];
                for (NSDictionary *dic in arr) {
                    NSString *manageName = [dic validValueForKey:@"cname"];
                    [_bannerArray addObject:manageName];
                    CSEventManageModel *manageMode = [[CSEventManageModel alloc] initWithDictionary:dic];
                    [self.eventManageArray addObject:manageMode];
                }
            }
            else
            {
                NSString *errorMessage = @"获取信息失败!";
                if (dicData && dicData[@"errmsg"]) {
                    errorMessage = [dicData valueForKeyPath:@"errmsg"];
                }
                [weakSelf.view showMessageHud:errorMessage];
            }
            
        } else {
            NSString *errorMessage = @"获取信息失败";
            if ([error code] == KNoNetWorkErrorCode || [error code] == KNoConnectNetErrorCode)
            {
                errorMessage = @"网络已断开，请检查您的网络连接！";
            }
            [weakSelf.view showMessageHud:errorMessage];
        }
    }];
}


//上传事件数据
-(void)SubmitData {
    __weak typeof(self) weakSelf = self;
    [weakSelf.view showMessageHud:@"加载中"];
    SAHttpNetworkManager *networkManager = [SAHttpNetworkManager defaultManager];
    NSString *manageNameCode = @"";//提交部门编号
    NSString *classCode = @"";//提交事件分类编号
    NSString *explainCode = @"";//提交事件说明编号
    [self.view showMessageHud:@"提交成功"];
    [self resetButtonClicked];
    return;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:SA_USERINFO_UsreID];
    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);

    if (_imageArray.count > 0) {
        //1.异步函数
        [self.photoJsonArr removeAllObjects];
            for (UIImage *image in _imageArray) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                manager.requestSerializer.timeoutInterval = 20;
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
                [manager POST:@"http://gowins.imwork.net:8680/mmm/index.php?s=/Api/Member/uploadImg" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
                    // 这里的_photoArr是你存放图片的数组
                    for (int i = 0; i < _imageArray.count; i++) {
                        NSData *imageData = UIImageJPEGRepresentation(image, 2);
                        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                        // 要解决此问题，
                        // 可以在上传时使用当前的系统事件作为文件名
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        // 设置时间格式
                        [formatter setDateFormat:@"yyyyMMddHHmmss"];
                        NSString *dateString = [formatter stringFromDate:[NSDate date]];
                        NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
                        /*
                         *该方法的参数
                         1. appendPartWithFileData：要上传的照片[二进制流]
                         2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
                         3. fileName：要保存在服务器上的文件名
                         4. mimeType：上传的文件的类型
                         */
                        [formData appendPartWithFileData:imageData name:@"picture" fileName:fileName mimeType:@"image/jpeg"]; //
                    }
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    //上传进度
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        NSLog(@"progress is %@",uploadProgress);
                    });
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *dicData = [responseObject isKindOfClass:[NSDictionary class]] ?(NSDictionary*)responseObject:nil;
                    if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                        NSString *string = [dicData validValueForKey:@"data"];
                        NSString *photoName = [AESCrypt decrypt:string password:kDefaultKey];
                        NSDictionary *photoDic = [photoName mj_JSONObject];
                        NSString *savename = [photoDic validValueForKey:@"savename"];
                        NSString *savepath = [photoDic validValueForKey:@"savepath"];
                        NSString *photoPath = [NSString stringWithFormat:@"%@%@",savepath,savename];
                        [self.photoJsonArr addObject:photoPath];
                        self.pathall = [self.photoJsonArr mj_JSONString];
                        [self resetButtonClicked];
                        
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            }
        
        // 3.延迟执行的第三种方法
        /**
         第一个参数：DISPATCH_TIME_NOW 从现在开始计算事件
         第二个参数：延迟的时间 GCD时间单位：那秒
         第叁个参数：队列
         */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [networkManager subEvent:userID eventName:_eventText.text explain:_instructionLabel.text eventClass:_eventTypeLabel.text location:_locationText.text manage:_inputManageCode video:@"" pathall:self.pathall callBack:^(id resp, NSError *error) {
                if (!error) {
                    NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
                    if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                        NSString *msg = [dicData validValueForKey:@"errmsg"];
                        [weakSelf.view showMessageHud:msg];
                        [self resetButtonClicked];
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
        });
        return;
    }
    
    //获取部门编号
    for (CSEventManageModel *tempanageMode in self.eventManageArray) {
        if ([_departmentLabel.text isEqualToString:tempanageMode.manageName]) {
            manageNameCode = tempanageMode.manageCode;
        }
    }
    //获取事件分类编号
    for (CSEventClassModel *classModel in self.eventDataArray) {
        if ([_instructionLabel.text isEqualToString:classModel.name]) {
            classCode = classModel.classId;
        }
    }
    //获取事件处理紧急状态编号
    int i = 1;
    for (NSString *string in _instructionsArray) {
        if ([self.eventTypeLabel.text isEqualToString:string]) {
            explainCode = [NSString stringWithFormat:@"%d",i];
        }
        i++;
    }
    
    DebugLog(@"提交部门%@",self.departmentLabel.text);
    DebugLog(@"事件分类%@",self.instructionLabel.text);
    DebugLog(@"事件说明%@",self.eventTypeLabel.text);
    
    DebugLog(@"部门编号%@",manageNameCode);
    DebugLog(@"分类编号%@",classCode);
    DebugLog(@"说明编号%@",explainCode);
    

    [networkManager subEvent:userID eventName:self.eventText.text explain:explainCode eventClass:classCode location:_locationText.text manage:manageNameCode video:@"" pathall:self.pathall callBack:^(id resp, NSError *error) {
        if (!error) {
            NSDictionary *dicData = [resp isKindOfClass:[NSDictionary class]] ?(NSDictionary*)resp:nil;
            if (dicData && [[dicData valueForKey:@"errcode"] integerValue] == KNETWORKOP_RESPONSE_SUCCEED_CODE) {
                DebugLog(@"%@",dicData);
                NSString *msg = [dicData validValueForKey:@"errmsg"];
                [weakSelf.view showMessageHud:msg];
                [self resetButtonClicked];
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

#pragma mark  UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            CSEventFunctionTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSEventFunctionTextCell cellIdentifier]];
            if (!cell) {
                cell = [[CSEventFunctionTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSEventFunctionTextCell cellIdentifier]];
            }
            cell.title = @"事件名称";
            cell.actionString = @"请填写事件名称";
            self.eventText = cell.contentText;
            cell.contentText.delegate = self;
            return cell;
        }
            break;
        case 4:
        {
            CSEventFunctionTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSEventFunctionTextCell cellIdentifier]];
            if (!cell) {
                cell = [[CSEventFunctionTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSEventFunctionTextCell cellIdentifier]];
            }
            cell.title = @"所在位置";
            cell.actionString = @"请填写位置";
            self.locationText = cell.contentText;
            cell.contentText.delegate = self;
            return cell;
        }
            break;
        default:
        {
            CSEventFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSEventFunctionTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSEventFunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSEventFunctionTableViewCell cellIdentifier]];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            cell.eventTitleLabel.text = [_bannerArray objectAtIndex:indexPath.row];
            _contentLabelArr[indexPath.row-1] = cell.contentLabel;
            _tempLabelArray[indexPath.row-1] = cell.backLogPriorityLabel;
            return cell;
        }
            break;
    }
    return nil;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65*SA_SCREEN_SCALE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 || indexPath.row == 4) {
        return;
    }
    [self.locationText resignFirstResponder];
    [self.eventText resignFirstResponder];
    
    _chooseIndex = indexPath;
    NSArray *chooseArr = [_sumArray objectAtIndex:(indexPath.row-1)];
    CSSelectorPickView *pick = [[CSSelectorPickView alloc] initWithDataArray:chooseArr];
    pick.delegate = self;
    self.pickView = pick;
    [UIView animateWithDuration:0.3 animations:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:pick];
    }];
}


#pragma mark  CSPhotoSelectViewDelegate 拍照 从照片中选取图片
-(void)photoSelectViewItem:(NSInteger)index {
    
}

#pragma mark  CSSelectorPickViewDelegate
-(void)pickViewSelectItem:(NSString *)item {
    CSEventFunctionTableViewCell *cell = [self.eventTableView cellForRowAtIndexPath:_chooseIndex];
    cell.backLogPriorityLabel.hidden = YES;
    cell.contentLabel.text = item;
    //点击事件说明cell -->选择事件-->获取提交部门cell-->展示对应处理事件部门
    if (_chooseIndex.row == 2) {
        _instructionLabel.text = item;
        NSIndexPath *lastPath = [NSIndexPath indexPathForRow:1 inSection:0];
        CSEventFunctionTableViewCell *cell = [self.eventTableView cellForRowAtIndexPath:lastPath];
        cell.backLogPriorityLabel.hidden = YES;
        for (CSEventClassModel *model in self.eventDataArray) {
            if (item == model.name) {
                cell.contentLabel.text =  model.manageName;
                _departmentLabel.text = model.manageName;
                _inputManageCode = model.manageCode;
                break;
            }
        }
        return;
    }
    if (_chooseIndex.row == 1) {
        _departmentLabel = cell.contentLabel;
        for (CSEventManageModel *model in self.eventManageArray) {
            if (item == model.manageName) {
                _inputManageCode = model.manageCode;
                DebugLog(@"%@",_inputManageCode);
            }
        }
        return;
    }
    _eventTypeLabel = cell.contentLabel;
}
-(void)pickViewSelectItem:(NSString *)item WithSelectString:(NSString *)selectID {
    
}

#pragma mark  CSEventFunctionHeaderViewDelegate 头部视图上的按钮事件
- (void)chooseFunctionItem:(NSInteger)itemIndex {
    NSInteger index = itemIndex-1000;
    if (index == 0) {
        CSEmergencyvViewController *emergencyVc = [[CSEmergencyvViewController alloc] init];
        emergencyVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:emergencyVc animated:YES];
    }else if (index == 2 ){
        self.eventHeaderView.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 350*SA_SCREEN_SCALE);
        self.eventTableView.tableHeaderView = self.eventHeaderView;
    }else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"正在开发中" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:sureAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)action_headerViewPhotoAddBtn {
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[HWImagePickerSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    [_imgPickerActionSheet showImgPickerActionSheetInView:self];
}

#pragma mark  CSEventFunctionFooterViewDelegate 尾部视图上按钮事件
-(void)action_footViewBtn {
    if (self.eventText.text.length == 0 || self.locationText.text.length == 0) {
        [self showError:@"请将资料填写完整"];
        return;
    }
    for (UILabel *label in _contentLabelArr) {
        if (label.text.length == 0) {
            [self showError:@"请将资料填写完整"];
            return;
        }
    }
    [self SubmitData];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Register nib file for the cell
    UINib *nib = [UINib nibWithNibName:@"HWCollectionViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"HWCollectionViewCell"];
    // Set up the reuse identifier
    HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"HWCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == _imageArray.count) {
        [cell.profilePhoto setImage:[UIImage imageNamed:pushImageName]];
        cell.closeButton.hidden = YES;
        //没有任何图片
        if (_imageArray.count == 0) {
            addImageStrLabel.hidden = NO;
        }
        else{
            addImageStrLabel.hidden = YES;
        }
    }else{
        [cell.profilePhoto setImage:_imageArray[indexPath.item]];
        cell.closeButton.hidden = NO;
    }
    [cell setBigImageViewWithImage:nil];
    cell.profilePhoto.tag = [indexPath item];
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    cell.profilePhoto.userInteractionEnabled = YES;
    [cell.profilePhoto  addGestureRecognizer:singleTap];
    cell.closeButton.tag = [indexPath item];
    [cell.closeButton addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self changeCollectionViewHeight];
    return cell;
}
#pragma mark UICollectionViewDelegate
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-64) /4 ,([UIScreen mainScreen].bounds.size.width-64) /4);
}
//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 8, 20, 8);
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addSubview:self.maskView];
    //添加图片cell点击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableCellProfileImage:)];
    singleTap.numberOfTapsRequired = 1;
    [self.maskView addGestureRecognizer:singleTap];
    if (textField == self.locationText) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didKboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.maskView removeFromSuperview];
    return YES;
}

#pragma mark - 图片cell点击事件
//点击图片看大图
- (void) tapProfileImage:(UITapGestureRecognizer *)gestureRecognizer{
    if (_imageArray.count == 7) {
        [self showError:@"照片数量已达到最大值"];
        return;
    }
    [self.view endEditing:YES];
    
    UIImageView *tableGridImage = (UIImageView*)gestureRecognizer.view;
    NSInteger index = tableGridImage.tag;
    
    if (index == (_imageArray.count)) {
        [self.view endEditing:YES];
        //添加新图片
        [self addNewImg];
    }
    else{
        //点击放大查看
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[_pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        if (!cell.BigImageView || !cell.BigImageView.image) {
            
            [cell setBigImageViewWithImage:[self getBigIamgeWithALAsset:_arrSelected[index]]];
        }
        
        JJPhotoManeger *mg = [JJPhotoManeger maneger];
        mg.delegate = self;
        [mg showLocalPhotoViewer:@[cell.BigImageView] selecImageindex:0];
    }
}

- (void)tapTableCellProfileImage:(UITapGestureRecognizer *)gestureRecognizer {
    [self.maskView removeFromSuperview];
    [self.locationText resignFirstResponder];
    [self.eventText resignFirstResponder];
}

- (UIImage*)getBigIamgeWithALAsset:(ALAsset*)set{
    //压缩
    // 需传入方向和缩放比例，否则方向和尺寸都不对
    UIImage *img = [UIImage imageWithCGImage:set.defaultRepresentation.fullResolutionImage
                                       scale:set.defaultRepresentation.scale
                                 orientation:(UIImageOrientation)set.defaultRepresentation.orientation];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
    [_bigImgDataArray addObject:imageData];
    
    return [UIImage imageWithData:imageData];
}
#pragma mark - 选择图片
- (void)addNewImg{
    if (!_imgPickerActionSheet) {
        _imgPickerActionSheet = [[HWImagePickerSheet alloc] init];
        _imgPickerActionSheet.delegate = self;
    }
    if (_arrSelected) {
        _imgPickerActionSheet.arrSelected = _arrSelected;
    }
    _imgPickerActionSheet.maxCount = _maxCount;
    [_imgPickerActionSheet showImgPickerActionSheetInView:_showActionSheetViewController];
}

#pragma mark - 删除照片
- (void)deletePhoto:(UIButton *)sender{
    [_imageArray removeObjectAtIndex:sender.tag];
    [_arrSelected removeObjectAtIndex:sender.tag];
    [self.pickerCollectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:sender.tag inSection:0]]];
    for (NSInteger item = sender.tag; item <= _imageArray.count; item++) {
        HWCollectionViewCell *cell = (HWCollectionViewCell*)[self.pickerCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0]];
        cell.closeButton.tag--;
        cell.profilePhoto.tag--;
    }
    [self changeCollectionViewHeight];
}

#pragma mark - 改变view，collectionView高度
- (void)changeCollectionViewHeight{
    if (_collectionFrameY) {
        _pickerCollectionView.frame = CGRectMake(0, _collectionFrameY, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
    else{
        _pickerCollectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
    }
    [self pickerViewFrameChanged];
}
/**
 *  相册完成选择得到图片
 */
-(void)getSelectImageWithALAssetArray:(NSArray *)ALAssetArray thumbnailImageArray:(NSArray *)thumbnailImgArray{
    //（ALAsset）类型 Array
    _arrSelected = [NSMutableArray arrayWithArray:ALAssetArray];
    //正方形缩略图 Array
    _imageArray = [NSMutableArray arrayWithArray:thumbnailImgArray] ;
    [self.pickerCollectionView reloadData];
}
- (void)pickerViewFrameChanged{
    
}
- (void)updatePickerViewFrameY:(CGFloat)Y{
    _collectionFrameY = Y;
    _pickerCollectionView.frame = CGRectMake(0, Y, [UIScreen mainScreen].bounds.size.width, (((float)[UIScreen mainScreen].bounds.size.width-64.0) /4.0 +20.0)* ((int)(_arrSelected.count)/4 +1)+20.0);
}

#pragma mark - 防止奔溃处理
-(void)photoViwerWilldealloc:(NSInteger)selecedImageViewIndex
{
    DebugLog(@"最后一张观看的图片的index是:%zd",selecedImageViewIndex);
}

- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}
//获得大图
- (NSArray*)getBigImageArrayWithALAssetArray:(NSArray*)ALAssetArray{
    _bigImgDataArray = [NSMutableArray array];
    NSMutableArray *bigImgArr = [NSMutableArray array];
    for (ALAsset *set in ALAssetArray) {
        [bigImgArr addObject:[self getBigIamgeWithALAsset:set]];
    }
    _bigImageArray = bigImgArr;
    return _bigImageArray;
}
#pragma mark - 获得选中图片各个尺寸
- (NSArray*)getALAssetArray{
    return _arrSelected;
}

- (NSArray*)getBigImageArray{
    return [self getBigImageArrayWithALAssetArray:_arrSelected];
}

- (NSArray*)getSmallImageArray{
    return _imageArray;
}

- (CGRect)getPickerViewFrame{
    return self.pickerCollectionView.frame;
}

#pragma mark  懒加载
- (UITableView *)eventTableView {
    if (!_eventTableView) {
        _eventTableView = ({
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT-64-49) style:UITableViewStylePlain];
            table.backgroundColor = SA_Color_RgbaValue(242, 242, 242, 1);
            table.tableHeaderView = self.eventHeaderView;
            table.tableFooterView = self.eventFooterView;
            table.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
            table.separatorStyle = UITableViewCellSeparatorStyleNone;
            table.delegate = self;
            table.dataSource = self;
            table;
        });
    }
    return _eventTableView;
}

- (CSEventFunctionHeaderView *)eventHeaderView {
    if (!_eventHeaderView) {
        _eventHeaderView = ({
            CSEventFunctionHeaderView *view = [[NSBundle mainBundle] loadNibNamed:
                                               @"CSEventFunctionHeaderView" owner:nil options:nil ].lastObject;
            view.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 125*SA_SCREEN_SCALE);
            view.delegate = self;
            view;
        });
    }
    return _eventHeaderView;
}

- (CSEventFunctionFooterView *)eventFooterView {
    if (!_eventFooterView) {
        _eventFooterView = ({
            CSEventFunctionFooterView * view = [[NSBundle mainBundle] loadNibNamed:@"CSEventFunctionFooterView" owner:nil options:nil].lastObject;
            view.frame = CGRectMake(0, 0, SA_SCREEN_WIDTH, 120*SA_SCREEN_SCALE);
            view.delegate = self;
            view;
        });
    }
    return _eventFooterView;
}

- (UILabel *)departmentLabel {
    if (!_departmentLabel) {
        _departmentLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label;
        });
    }
    return _departmentLabel;
}

- (UILabel *)instructionLabel {
    if (!_instructionLabel) {
        _instructionLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label;
        });
    }
    return _instructionLabel;
}

- (UILabel *)eventTypeLabel {
    if (!_eventTypeLabel) {
        _eventTypeLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label;
        });
    }
    return _eventTypeLabel;
}

- (UITextField *)eventText {
    if (!_eventText) {
        _eventText = [[UITextField alloc] init];
    }
    return _eventText;
}

- (UITextField *)locationText {
    if (!_locationText) {
        _locationText = [[UITextField alloc] init];
    }
    return _locationText;
}

#pragma mark  弹框提示
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}
#pragma mark -  键盘即将跳出
-(void)didClickKeyboard:(NSNotification *)sender{
    CGFloat durition = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    CGRect keyboardRect = [sender.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:durition animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -(keyboardHeight/2.0));
    }];
}
#pragma mark -      当键盘即将消失
-(void)didKboardDisappear:(NSNotification *)sender{
    CGFloat duration = [sender.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
@end
