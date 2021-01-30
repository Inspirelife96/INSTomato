//
//  INSBackgroundImageManager.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSBackgroundImageManager : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END
