//
//  INSTomatoConfiguration.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, INSSupportedPluginType) {
    INSSupportedPluginTypeClose = 0,
    INSSupportedPluginTypeTask,
    INSSupportedPluginTypeStatistics,
    INSSupportedPluginTypeSetting,
    INSSupportedPluginTypeStory,
    INSSupportedPluginTypeNone = 9999,
};

@interface INSTomatoConfiguration : NSObject

@property (nonatomic, assign) BOOL isAddTaskEnabled;

@property (nonatomic, strong) UIImage *backgrondImage; //背景图片，如果为nil，则使用默认的bing图片

@property (nonatomic, assign) INSSupportedPluginType topLeftPluginType;
@property (nonatomic, assign) INSSupportedPluginType topRightPluginType;
@property (nonatomic, assign) INSSupportedPluginType bottomLeftPluginType;
@property (nonatomic, assign) INSSupportedPluginType bottomRightPluginType;

@end

NS_ASSUME_NONNULL_END
