//
//  INSTomato.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import <Foundation/Foundation.h>

@class INSTomatoConfiguration;

NS_ASSUME_NONNULL_BEGIN

@interface INSTomato : NSObject

+ (void)initializeWithConfiguration:(INSTomatoConfiguration *)configuration;
+ (void)resetWithConfiguration:(INSTomatoConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
