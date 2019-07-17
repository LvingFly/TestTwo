//
//  CSEventFunctionHeaderView.m
//  CloudShoppingSystem
//
//  Created by dengyuchi on 2017/6/28.
//  Copyright © 2017年 dengyuchi. All rights reserved.
//

#import "CSEventFunctionHeaderView.h"
#import "HWImagePickerSheet.h"

@interface CSEventFunctionHeaderView ()
/*
 * 三个按钮的tag值 在xib中设置 分别为1000 1001 1002 
 */
@property (weak, nonatomic) IBOutlet UIButton *emergencyBtn;//紧急事件按钮
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;//录像按钮
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;//拍照按钮
@property (weak, nonatomic) IBOutlet UIView *bottomLine;


@end


@implementation CSEventFunctionHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.backgroundColor = SA_Color_RgbaValue(242, 242, 242, 1);
        
        [self initSubView];
    }
    return self;
}

-(void)initSubView {

}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.bottomLine.backgroundColor = SA_Color_RgbaValue(203, 203, 203, 1);
}



/*
 * xib中三个按钮点击出发都为此事件
 */
- (IBAction)action_button:(UIButton *)sender {
    
    
    //判断点击哪个按钮事件
    NSInteger chooItemIndex = sender.tag;
    if ([self.delegate respondsToSelector:@selector(chooseFunctionItem:)]) {
        [self.delegate chooseFunctionItem:chooItemIndex];
    }
}

- (IBAction)action_plusBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(action_headerViewPhotoAddBtn)]) {
        [self.delegate action_headerViewPhotoAddBtn];
    }
    
}



@end
