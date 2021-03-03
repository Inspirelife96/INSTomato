//
//  UIViewController+INS_AlertView.h
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (INS_AlertView)

- (void)alertErrorWithTitle:(NSString *)title subTitle:(NSString *)subTtile;
- (void)alertInfoWithTitle:(NSString *)title subTitle:(NSString *)subTtile;

@end

NS_ASSUME_NONNULL_END
