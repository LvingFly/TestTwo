
//
//  CSEmergencyvViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/29.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEmergencyvViewController.h"
#import "CSEmergencyvCell.h"

@interface CSEmergencyvViewController ()

@end

@implementation CSEmergencyvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[CSEmergencyvCell class] forCellReuseIdentifier:[CSEmergencyvCell cellIdentifier]];
    
    [self initSubView];
}

-(void)initNavButtons
{
    [super initNavButtons];

    UILabel *titleLabel = [SAControlFactory createLabel:@"选择联系人" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(18) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initSubView {

}

#pragma -mark UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CSEmergencyvCell *cell = [tableView dequeueReusableCellWithIdentifier:[CSEmergencyvCell cellIdentifier]];
    
    if (cell == nil)
    {
        cell = [[CSEmergencyvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CSEmergencyvCell cellIdentifier]];
    }
    

    cell.imageStr = @"Head_01.png";
    cell.phoneNumbe = @"15708431929";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",cell.textLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    

    
}


@end
