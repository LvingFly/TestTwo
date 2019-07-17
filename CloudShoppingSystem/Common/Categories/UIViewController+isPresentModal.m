//
//  UIViewController+isPresentModal.m
//  SinaWeather
//
//  Created by iBcker on 14-5-13.
//
//

#import "UIViewController+isPresentModal.h"

@implementation UIViewController (isPresentModal)

- (BOOL)isPresentModal
{
    return [self.navigationController.viewControllers firstObject]==self;
}
@end
