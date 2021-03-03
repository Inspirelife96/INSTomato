//
//  INSTomatoBundle.h
//  INSTomato-INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoBundle : NSObject

+ (NSBundle *)bundle;

+ (UIImage *)imageNamed:(NSString *)name;

+ (UIImageView *)accessoryView;

+ (void)loadSpecialFont;

@end

NS_ASSUME_NONNULL_END
