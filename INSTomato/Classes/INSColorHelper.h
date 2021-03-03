//
//  INSColorHelper.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/1/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSColorHelper : NSObject

+ (UIColor *)colorByName:(NSString *)colorName;
+ (NSArray *)colorNameList;

@end

NS_ASSUME_NONNULL_END
