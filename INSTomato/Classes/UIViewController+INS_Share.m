//
//  UIViewController+INS_Share.m
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/26.
//

#import "UIViewController+INS_Share.h"

//#import <SCLAlertView-Objective-C/SCLAlertView.h>

@implementation UIViewController (INS_Share)



- (void)shareWithText:(NSString *)text url:(NSURL *)url image:(UIImage *)image CompletionWithItemsHandler: (UIActivityViewControllerCompletionWithItemsHandler)completionWithItemsHandler {
    NSArray *activityItems = @[text, image, url];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    activityVC.completionWithItemsHandler = completionWithItemsHandler;

    [self presentViewController:activityVC animated:YES completion:nil];
}

@end
