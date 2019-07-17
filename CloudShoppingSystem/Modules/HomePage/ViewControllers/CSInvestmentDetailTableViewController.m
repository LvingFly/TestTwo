//
//  CSInvestmentDetailTableViewController.m
//  
//
//  Created by dengyuchi on 2017/5/5.
//
//
//招商记录详情
#import "CSInvestmentDetailTableViewController.h"
#import "CSInvestmentDetailNormalTableViewCell.h"
#import "CSInvestmentDetailSelectTableViweCell.h"
#import "CSInvestmentDetailFooterView.h"
#import "CSSelectPickerView.h"
#import "CSDatePickerView.h"

@interface CSInvestmentDetailTableViewController ()<CSInvestmentDetailSelectTableViweCellDelegate>

@property(nonatomic, strong)NSArray     *titleArray;
@property(nonatomic, strong)CSInvestmentDetailFooterView *footerView;

@end

@implementation CSInvestmentDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@[@"谈判编号",@"项目",@"谈判模式",@"我方谈判人员",@"对方谈判人员",@"谈判日期",@"谈判地点",@"谈判进度"],
                        @[@"商户基本信息",@"品牌名称",@"商户",@"客户姓名",@"客户状态",@"意向楼宇",@"意向单元",@"商品/业态结构"],
                        @[@"主题",@"客户来源",@"期望起租日期",@"期望租期",@"期望起租面积(m²)",@"期望租金范围(元)",@"业界预估",@"预期目标",@"目标情况",@"洽谈内容",@"下次洽谈目标",@"商户是否已落位"]];
    self.tableView.height = SA_SCREEN_HEIGHT - SA_NAVBAR_HEIGHT_WITH_STATUS_BAR;
    self.tableView.separatorColor = SA_Color_HexString(0xf2f2f2, 1);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    DebugLog(@"%@",self.detailModel);
    
    CGFloat footerHeight = [self.footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    self.footerView.height = footerHeight;
    self.footerView.height = 60*SA_SCREEN_SCALE;
//    self.tableView.tableFooterView = self.footerView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"添加招商记录" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

#pragma -mark UITableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 35 * SA_SCREEN_SCALE;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 35 * SA_SCREEN_SCALE)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CSInvestmentDetailSelectTableViweCell cellHeight];
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
            return 8;
            break;
        case 2:
            return 12;
            break;
        default:
            break;
    }
    return 0;
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
            NSArray *titleList = [self.titleArray objectAtIndex:indexPath.section];
            if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 5) {
               CSInvestmentDetailSelectTableViweCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSInvestmentDetailSelectTableViweCell cellIdentifier]];
                if (!cell) {
                    cell = [[CSInvestmentDetailSelectTableViweCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSInvestmentDetailSelectTableViweCell cellIdentifier]];
                }
                cell.delegate = self;
                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                
                return cell;
            }else
            {
                CSInvestmentDetailNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSInvestmentDetailNormalTableViewCell cellIdentifier]];
                if (!cell) {
                    cell = [[CSInvestmentDetailNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSInvestmentDetailNormalTableViewCell cellIdentifier]];
                }
                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                return cell;
            }
        }
            break;
        case 1:
        {
            NSArray *titleList = [self.titleArray objectAtIndex:indexPath.section];
            if (indexPath.row == 3 || indexPath.row == 7) {
                CSInvestmentDetailNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@1",[CSInvestmentDetailNormalTableViewCell cellIdentifier]]];
                if (!cell) {
                    cell = [[CSInvestmentDetailNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@1",[CSInvestmentDetailNormalTableViewCell cellIdentifier]]];
                }
                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                return cell;
            }else
            {
                CSInvestmentDetailSelectTableViweCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@,1", [CSInvestmentDetailSelectTableViweCell cellIdentifier]]];
                if (!cell) {
                    cell = [[CSInvestmentDetailSelectTableViweCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@,1", [CSInvestmentDetailSelectTableViweCell cellIdentifier]]];
                }
                cell.delegate = self;

                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                return cell;
            }
        }
            break;
        case 2:
        {
            NSArray *titleList = [self.titleArray objectAtIndex:indexPath.section];
            if (indexPath.row == 2 || indexPath.row == 11) {
                CSInvestmentDetailSelectTableViweCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@2", [CSInvestmentDetailSelectTableViweCell cellIdentifier]]];
                if (!cell) {
                    cell = [[CSInvestmentDetailSelectTableViweCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@,2", [CSInvestmentDetailSelectTableViweCell cellIdentifier]]];
                }
                cell.delegate = self;
                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                return cell;
            }else
            {
                CSInvestmentDetailNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@2",[CSInvestmentDetailNormalTableViewCell cellIdentifier]]];
                if (!cell) {
                    cell = [[CSInvestmentDetailNormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%@2",[CSInvestmentDetailNormalTableViewCell cellIdentifier]]];
                }
                if (indexPath.row < titleList.count) {
                    NSString *titleString = [titleList objectAtIndex:indexPath.row];
                    [cell setTitleString:titleString];
                    [cell setIndexPath:indexPath];
                }
                return cell;
            }
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
    
    
    
    if ((indexPath.section == 0 && indexPath.row == 5) || (indexPath.section == 2 && indexPath.row == 2)) {//选择日期
        CSDatePickerView *datePickerView = [[CSDatePickerView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT) withDataArray:@[@"1",@"2",@"3",@"4",@"5"]];
        [datePickerView didSelectDateAtIndex:^(NSString *dateString) {
            NSLog(@"选择了第%@个",dateString);
        }];
        NSString *titleString = self.titleArray[indexPath.section][indexPath.row];
        [datePickerView setTitleString:titleString];
        [self.navigationController.view addSubview:datePickerView];
    }else
    {
        CSSelectPickerView *selectPickerView = [[CSSelectPickerView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT) withDataArray:@[@"1",@"2",@"3",@"4",@"5"]];
        [selectPickerView didSelectItemAtIndex:^(NSInteger index) {
            NSLog(@"选择了第%ld个",index);
        }];
        NSString *titleString = self.titleArray[indexPath.section][indexPath.row];
        [selectPickerView setTitleString:titleString];
        [self.navigationController.view addSubview:selectPickerView];
    }
}

#pragma --mark 懒加载
-(CSInvestmentDetailFooterView *)footerView
{
    if (!_footerView) {
        _footerView = ({
            CSInvestmentDetailFooterView *view = [[CSInvestmentDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 1 * SA_SCREEN_SCALE)];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _footerView;
}

@end
