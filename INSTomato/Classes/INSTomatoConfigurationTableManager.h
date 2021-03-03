//
//  INSTomatoConfigurationTableManager.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import <Foundation/Foundation.h>

#import "INSTomatoConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoConfigurationTableManager : NSObject

+ (void)createTomatoConfigurationTable:(INSTomatoConfiguration *)tomatoConfiguration;
+ (void)resetTomatoConfigurationTable:(INSTomatoConfiguration *)tomatoConfiguration;

+ (instancetype)sharedInstance;

- (void)configBackgroundImage:(UIImage *)backgroundImage;
- (void)configActivedTask:(INSTaskModel *)taskModel;

- (BOOL)isAddTaskEnabled;
- (NSString *)title;
- (NSString *)subTitle;
- (UIImage *)icon;
- (UIImage *)backgroundImage;
- (UIImage *)sharedCodeImage;
- (NSURL *)sharedUrl;
- (INSSupportedPluginType)topLeftPluginType;
- (INSSupportedPluginType)topRightPluginType;
- (INSSupportedPluginType)bottomLeftPluginType;
- (INSSupportedPluginType)bottomRightPluginType;

- (INSTaskModel *)activedTask;

- (BOOL)isSpecialFontOptionEnabled;
- (NSString *)specialFontResourcePath;
- (NSString *)specialFontName;

- (BOOL)isMusicOptionEnabled;
- (NSArray *)musicNameArray;
- (NSArray *)musicUrlPathArray;
- (NSURL *)musicUrlForMusicName:(NSString *)musicName;

@end

NS_ASSUME_NONNULL_END
