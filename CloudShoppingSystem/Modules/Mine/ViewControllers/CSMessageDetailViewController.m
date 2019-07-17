//
//  CSMessageDetailViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/4.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSMessageDetailViewController.h"
#import "CSMessageInfoTableViewCell.h"
#import "CSMessageScheduleTableViewCell.h"

@interface CSMessageDetailViewController ()

@property(nonatomic, strong)NSArray     *titleArray;

@end

@implementation CSMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArray = @[@"事件名称：",@"提交人：",@"提交时间："];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavButtons
{
    [super initNavButtons];
    UILabel *titleLabel = [SAControlFactory createLabel:@"消息详情" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
}

#pragma -mark UITableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SA_SCREEN_WIDTH, 35 * SA_SCREEN_SCALE)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [CSMessageInfoTableViewCell cellHeight];
            break;
        case 1:
            return [CSMessageScheduleTableViewCell cellHeight];
            break;
        default:
            break;
    }
    return 0;
}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.titleArray.count;
            break;
        case 1:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            CSMessageInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSMessageInfoTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSMessageInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSMessageInfoTableViewCell cellIdentifier]];
            }
            if (indexPath.row < self.titleArray.count) {
                NSString *title = [self.titleArray objectAtIndex:indexPath.row];
                [cell setTitleString:title];
            }
            return cell;
        }
            break;
        case 1:
        {
            CSMessageScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSMessageScheduleTableViewCell cellIdentifier]];
            if (!cell) {
                cell = [[CSMessageScheduleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSMessageScheduleTableViewCell cellIdentifier]];
            }
            if (indexPath.row == 3) {
                [cell setLineViewHidden:YES];
            }
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

@end
