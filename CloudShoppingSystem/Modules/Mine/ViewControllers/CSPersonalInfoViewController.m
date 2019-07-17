//
//  CSPersonalInfoViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSPersonalInfoViewController.h"
#import "CSPersonalInfoTableViewCell.h"
#import "CSChangeHeadImagePopUpView.h"

@interface CSPersonalInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic, strong)UIImageView             *headImageView;
@property(nonatomic, strong)UILabel                 *nickNameLabel;
@property(nonatomic, strong)NSArray                 *titleArray;
@property(nonatomic, strong)NSArray                 *valueArray;

@property(nonatomic, strong)CSChangeHeadImagePopUpView  *changeHeadImageView;

@end

@implementation CSPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"用户名：",@"生日：",@"性别：",@"所在地："];
    self.valueArray = @[@"Tommy",@"1992-03-18",@"男",@"四川-成都"];
    [self initHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"个人信息" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

-(void)initHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 110 * SA_SCREEN_SCALE)];
    headerView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:self.headImageView];
    [headerView addSubview:self.nickNameLabel];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.top.mas_equalTo(10 * SA_SCREEN_SCALE);
        make.height.width.mas_equalTo(66 * SA_SCREEN_SCALE);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView);
        make.top.mas_equalTo(self.headImageView.mas_bottom).offset(2 * SA_SCREEN_SCALE);
    }];
    self.tableView.tableHeaderView = headerView;
}

-(void)selectHeadImageWithType:(ESelectHeadImageType)type
{
    UIImagePickerControllerSourceType sourceType;
    switch (type) {
        case ESelectImageCameraType:
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case ESelectImagePhotoAblumType:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }
    //初始化UIImagePickerController
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    PickerImage.sourceType = sourceType;
    //允许编辑，即放大裁剪
    PickerImage.allowsEditing = YES;
    //自代理
    PickerImage.delegate = self;
    //页面跳转
    [self presentViewController:PickerImage animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //    NSData * imageData = UIImageJPEGRepresentation(newPhoto, 0.1);
    //    NSString *imageDataString = [imageData base64Encoding];
    [self.headImageView setImage:newPhoto];
    //    DebugLog(@"%@",imageDataString);
    
    //    [self changeHeadImage:imageData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma --mark event clicked
-(void)changeHeaderImage:(UITapGestureRecognizer *)tap
{//更换头像
    [self.view addSubview:self.changeHeadImageView];
    
    [self.changeHeadImageView scrollToTop];
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CSPersonalInfoTableViewCell cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSPersonalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSPersonalInfoTableViewCell cellIdentifier]];
    if (!cell) {
        cell = [[CSPersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSPersonalInfoTableViewCell cellIdentifier]];
    }
    if (indexPath.row < self.titleArray.count) {
        NSString *title = [self.titleArray objectAtIndex:indexPath.row];
        NSString *value = [self.valueArray objectAtIndex:indexPath.row];
        [cell setValueString:value];
        [cell setTitleString:title];
    }
    return cell;
}

#pragma --mark 懒加载
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView  = ({
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView setImage:[UIImage imageNamed:@"headImage"]];
            imageView.layer.cornerRadius = 33 * SA_SCREEN_SCALE;
            imageView.clipsToBounds = YES;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHeaderImage:)];
            [imageView addGestureRecognizer:headerTap];
            imageView;
        });
    }
    return _headImageView;
}

-(UILabel *)nickNameLabel
{
    if (!_nickNameLabel) {
        _nickNameLabel = ({
            UILabel *label = [SAControlFactory createLabel:@"Tommy" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(16) textColor:SA_Color_HexString(0x333333, 1) textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
            label;
        });
    }
    return _nickNameLabel;
}

-(CSChangeHeadImagePopUpView *)changeHeadImageView
{
    if (!_changeHeadImageView) {
        _changeHeadImageView = ({
            CSChangeHeadImagePopUpView *view = [[CSChangeHeadImagePopUpView alloc]initWithFrame:self.view.bounds];
            [view setHeadImageBlock:^(ESelectHeadImageType selectType)
             {
                 [self selectHeadImageWithType:selectType];
             }];
            view;
        });
    }
    return _changeHeadImageView;
}

@end
