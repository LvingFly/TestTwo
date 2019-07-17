//
//  CSHistoryPollingView.m
//  
//
//  Created by dengyuchi on 2017/5/17.
//
//

#import "CSHistoryPollingView.h"
#import "CSPollingSelectTableViewCell.h"
#import "CSPollingNormalTableViewCell.h"
#import "CSSelectPickerView.h"
#import "CSDatePickerView.h"
#import "CSLocationView.h"

@interface CSHistoryPollingView ()<CSPollingSelectTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView     *tableView;
@property(nonatomic, strong)NSArray         *titleListArray;
@property(nonatomic, strong)UIImageView     *locationImageView;         //显示的定位的图片
@property(nonatomic, strong)CSLocationView     *locationView;         //显示的定位的图片
@end

@implementation CSHistoryPollingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleListArray = @[@[@"时间",@"巡检人员"],@[@"姓名",@"联系方式",@"所属部门",@"巡检作业"]];
        [self initSubView];
        [self initFooterView];
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

-(void)initFooterView
{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 240 * SA_SCREEN_SCALE)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(8 * SA_SCREEN_SCALE,0,SA_SCREEN_WIDTH - 16 * SA_SCREEN_SCALE, 1 * SA_SCREEN_SCALE)];
    lineView.backgroundColor = SA_Color_HexString(0xe5e2dc, 1);
    [footerView addSubview:lineView];
    
    [footerView addSubview:self.locationView];
    self.locationView.height = 210 * SA_SCREEN_SCALE;
    self.locationView.width = 300 * SA_SCREEN_SCALE;
    self.locationView.centerX = footerView.centerX;
    self.locationView.top = 12 * SA_SCREEN_SCALE;
    
    self.tableView.tableFooterView = footerView;
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44 * SA_SCREEN_SCALE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 35 * SA_SCREEN_SCALE;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 35 * SA_SCREEN_SCALE)];
        headerView.backgroundColor = [UIColor clearColor];
        return headerView;
    }
    return nil;
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else
    {
        return 4;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = [self.titleListArray objectAtIndex:indexPath.section];
    switch (indexPath.section) {
        case 0:
        {
            CSPollingSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSPollingSelectTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSPollingSelectTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSPollingSelectTableViewCell cellIdentifier]];
            }
            NSString *titleString = [titleArray objectAtIndex:indexPath.row];
            cell.indexPath = indexPath;
            [cell setTitleString:titleString];
            cell.delegate = self;
            return cell;
        }
            break;
        case 1:
        {
            CSPollingNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSPollingNormalTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSPollingNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSPollingNormalTableViewCell cellIdentifier]];
            }
            
            if (indexPath.row < titleArray.count) {
                NSString *titleString = [titleArray objectAtIndex:indexPath.row];
                cell.indexPath = indexPath;
                [cell setTitleString:titleString];
            }
            if (indexPath.row == titleArray.count -1) {
                [cell changeValueTextColor:@"#34d569"];
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma --mark CSInvestmentDetailSelectTableViweCellDelegate
//选择了那一行的Cell button
-(void)selectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *titleArray = [self.titleListArray objectAtIndex:indexPath.section];
    CSPollingSelectTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CSDatePickerView *datePickerView = [[CSDatePickerView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT) withDataArray:@[@"1",@"2",@"3",@"4",@"5"]];
            [datePickerView didSelectDateAtIndex:^(NSString *dateString) {
                [cell.selectButton setTitle:dateString forState:UIControlStateNormal];
                NSLog(@"选择了第%@个",dateString);
            }];
            NSString *titleString = [titleArray objectAtIndex:indexPath.row];
            [datePickerView setTitleString:titleString];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:datePickerView];
        }else
        {
            NSArray *personArr = [NSArray arrayWithObjects:@"1",@"20",@"3",@"4",@"5",nil];
            CSSelectPickerView *selectPickerView = [[CSSelectPickerView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT) withDataArray:personArr];
            [selectPickerView didSelectItemAtIndex:^(NSInteger index) {
                NSLog(@"选择了第%ld个",index);
                [cell.selectButton setTitle:personArr[index] forState:UIControlStateNormal];
            }];
            
            NSArray *InfoArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",nil];
            for (int i = 0; i < 4; i++) {
                NSIndexPath *cellIndex = [NSIndexPath indexPathForRow:i inSection:1];
                CSPollingNormalTableViewCell *cell = [self.tableView cellForRowAtIndexPath:cellIndex];
                [cell.contentLabel setText:InfoArr[i]];
            }
            
            if (indexPath.row < titleArray.count) {
                NSString *titleString = [titleArray objectAtIndex:indexPath.row];
                [selectPickerView setTitleString:titleString];
            }
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:selectPickerView];
        }
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
            view.separatorColor = [UIColor colorWithHexString:@"#e5e2dc"];
            view.separatorInset = UIEdgeInsetsMake(0, 8 * SA_SCREEN_SCALE, 0, 8 * SA_SCREEN_SCALE);
            view.backgroundColor = [UIColor clearColor];
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view;
        });
    }
    return _tableView;
}

-(UIImageView *)locationImageView
{
    if (!_locationImageView) {
        _locationImageView = ({
            UIImageView *view = [[UIImageView alloc]init];
            view.backgroundColor = [UIColor clearColor];
            [view setImage:[UIImage imageNamed:@"locationImage"]];
            view;
        });
    }
    return _locationImageView;
}

- (CSLocationView *)locationView {
    if (!_locationView) {
        _locationView = [[CSLocationView alloc] init];
    }
    return _locationView;
}


@end
