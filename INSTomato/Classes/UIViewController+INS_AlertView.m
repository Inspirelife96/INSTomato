//
//  UIViewController+INS_AlertView.m
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/26.
//

#import "UIViewController+INS_AlertView.h"

#import <SCLAlertView_Objective_C/SCLAlertView-Objective-C-umbrella.h>

@implementation UIViewController (INS_AlertView)

- (void)alertErrorWithTitle:(NSString *)title subTitle:(NSString *)subTtile {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showError:self title:title subTitle:subTtile closeButtonTitle:@"确认" duration:0.0f];
}

- (void)alertInfoWithTitle:(NSString *)title subTitle:(NSString *)subTtile {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert showInfo:self title:title subTitle:subTtile closeButtonTitle:@"确认" duration:0.0f];
}

@end
