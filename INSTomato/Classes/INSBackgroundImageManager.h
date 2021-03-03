//
//  INSBackgroundImageManager.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSBackgroundImageManager : NSObject

@property (nonatomic, strong) UIImage *backgroundImage;

+ (instancetype)sharedInstance;

- (void)configBackgroundImage:(UIView *)parentView;

@end

NS_ASSUME_NONNULL_END
