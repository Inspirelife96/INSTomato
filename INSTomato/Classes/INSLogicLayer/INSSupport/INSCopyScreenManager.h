//
//  INSCopyScreenManager.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSCopyScreenManager : NSObject

@property (nonatomic, strong) UIImage *copiedScreenImage;

+ (instancetype)sharedInstance;

- (void)copyScreen:(UIView *)copiedView;

@end

NS_ASSUME_NONNULL_END
