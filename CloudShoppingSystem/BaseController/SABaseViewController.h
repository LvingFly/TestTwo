//
//  SABaseViewController.h
//  SuperAssistant
//
//  Created by 飞光普 on 15/4/27.
//  Copyright (c) 2015年 飞光普. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    EUnknownViewController,
    EBaseViewController,
    ERefreshViewController,
    EBaseTableViewController,
    EBaseCollectionViewController,
//    EShopServeViewController,
//    EStatQueryViewController,
    EMineViewController,
    EDeliveryVoucherQueryVC,
    EDVDetailViewController,
    EScanQRCodeViewController,
    EOrderStatViewController,
    EPofStatViewController,
    EOrderFormDetailViewController,
}SAViewControllerType;

@interface SABaseViewController : UIViewController
{
    //注意：只有当有viewcontroller嵌套时，才使用这个属性
    __weak UIViewController *superViewController;//当把自己的view加载到其他viewcontroller里面的view上时，引用其他viewcontroller为自己的父窗体
}

@property(nonatomic, weak)UIViewController *superViewController;

//ViewContoller类型
@property(nonatomic, readwrite)SAViewControllerType type;

//子类在此函数注册通知和KVO，注意，重载后需要子类初始化Model等对象后重新调用
-(void)registNotificationAndKVO;
//子类再此函数移除通知和KVO
-(void)removeNotificationAndKVO;

//子类实现，初始化导航栏按钮
-(void)initNavButtons;

@end
