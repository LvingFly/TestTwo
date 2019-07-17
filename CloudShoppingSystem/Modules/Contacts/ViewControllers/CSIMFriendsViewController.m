
//
//  CSIMFriendsViewController.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/7/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSIMFriendsViewController.h"
#import "IMFriendsCell.h"
#import "CSChatListItem.h"
#import "CSSingleChatViewController.h"


@interface CSIMFriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *friendListTable;

@property (nonatomic, strong) NSMutableArray *dateMutablearray;
@property (nonatomic, strong) NSMutableArray *totalArray;

@end

@implementation CSIMFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initSubview];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
    NSMutableArray *listArr = [NSMutableArray array];//装有所有模型的数组
    NSMutableArray *totalArr = [NSMutableArray array];//装有所有部门信息模型的数组
    /*
     * 算法逻辑 通过模型中manageCode的不同来区分所属模型在哪个部门，并将模型添加到这个部门的数组内，最后再用一个大的数组来添加这些部门的数组
     */
    //将所有模型添加到数组内
    for (NSDictionary *dic in _dataArr) {
        CSChatListItem *item =  [[CSChatListItem alloc]initWithDictionary:dic];
        [listArr addObject:item];
    }
    
    
    
    self.totalArray = [NSMutableArray arrayWithArray:listArr];
    
    self.dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < self.totalArray.count; i ++) {
        
        CSChatListItem *item = self.totalArray[i];
        NSString *string = item.mangeCode;
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:item];
        
        for (int j = i+1; j < self.totalArray.count; j ++) {
            CSChatListItem *jItem = self
            .totalArray[j];

            NSString *jstring = jItem.mangeCode;
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:jItem];
                
                [self.totalArray removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [self.dateMutablearray addObject:tempArray];
        
    }
    
    
    
    
    
    
    DebugLog(@"%@",_dateMutablearray);

    
    
    
}

-(void)initNavButtons
{
    [super initNavButtons];
    
    UILabel *titleLabel = [SAControlFactory createLabel:@"通讯录" backgroundColor:[UIColor clearColor] font:SA_FontPingFangLightWithSize(20) textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineBreakMode:NSLineBreakByWordWrapping];
    self.navigationItem.titleView = titleLabel;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubview {
    [self.view addSubview:self.friendListTable];
}

#pragma mark  UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dateMutablearray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dateMutablearray[section];
    return arr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *arr = self.dateMutablearray[section];
    CSChatListItem *item = arr[0];
    return item.manageName;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *arr = self.dateMutablearray[section];
    CSChatListItem *item = arr[0];
    
    UILabel *artLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, (44)/2, SA_SCREEN_WIDTH / 2. - 1 - 45  , 20)];
    artLabel.centerY = 22;
    [artLabel setBackgroundColor:[UIColor clearColor]];
    [artLabel setFont:[UIFont systemFontOfSize:15]];
    [artLabel setTextColor:KNavBarColor];

    [artLabel setText:[NSString stringWithFormat:@"%@",item.manageName]];
    return artLabel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IMFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:[IMFriendsCell cellIdentifier]];
    if (!cell) {
        cell = [[IMFriendsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[IMFriendsCell cellIdentifier]];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    NSArray *itemArr = self.dateMutablearray[indexPath.section];
    CSChatListItem *item = itemArr[indexPath.row];
    cell.eventTitleLabel.text = item.nickName;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CSChatListItem *item = self.dateMutablearray[indexPath.section][indexPath.row];
    CSSingleChatViewController *chat = [[CSSingleChatViewController alloc] initWithConversationType:ConversationType_PRIVATE
    targetId:item.userId];
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = item.userId;
    //设置聊天会话界面要显示的标题
    chat.titleLabel = item.nickName;
    //显示聊天会话界面
    chat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chat animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark  懒加载
- (UITableView *)friendListTable {
    if (!_friendListTable) {
        _friendListTable = ({
            UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SA_SCREEN_WIDTH, SA_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
            table.backgroundColor = SA_Color_RgbaValue(242, 242, 242, 1);
            table.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
            table.separatorStyle = UITableViewCellSeparatorStyleNone;
            table.delegate = self;
            table.dataSource = self;
            table;
        });
    }
    return _friendListTable;
}

@end
