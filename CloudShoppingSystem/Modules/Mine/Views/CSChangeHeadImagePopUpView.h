//
//  CSChangeHeadImagePopUpView.h
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/5/5.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ESelectImageCameraType,//相机
    ESelectImagePhotoAblumType,//相册
}ESelectHeadImageType;

typedef void(^SelectHeadImageBlock)(ESelectHeadImageType selectType);

@interface CSChangeHeadImagePopUpView : UIView

-(void)scrollToTop;
-(void)scrollToBottom;

@property(nonatomic,copy)SelectHeadImageBlock headImageBlock;


@end
