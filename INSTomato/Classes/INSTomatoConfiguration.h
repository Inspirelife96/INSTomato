//
//  INSTomatoConfiguration.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/3.
//

#import <Foundation/Foundation.h>

@class INSTaskModel;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, INSSupportedPluginType) {
    INSSupportedPluginTypeNone = 0,
    INSSupportedPluginTypeClose,
    INSSupportedPluginTypeTask,
    INSSupportedPluginTypeStatistics,
    INSSupportedPluginTypeBookmark
};

@interface INSTomatoConfiguration : NSObject

// 任务列表
@property (nonatomic, strong) NSArray<INSTaskModel *> *taskModelArray;

// 激活的任务，必须是上面列表中的一个
@property (nonatomic, strong) INSTaskModel *activedTask;

// 是否允许添加/删除任务
@property (nonatomic, assign) BOOL isAddTaskEnabled;

@property (nonatomic, copy) NSString *tomatoTitle;

@property (nonatomic, copy) NSString *tomatoSubTitle;

@property (nonatomic, strong) UIImage *tomatoIcon;

@property (nonatomic, strong) UIImage *tomatoBackgroundImage;

@property (nonatomic, strong) UIImage *sharedCodeImage;

@property (nonatomic, strong) NSString *sharedUrlString;

@property (nonatomic, assign) INSSupportedPluginType topLeftPluginType;

@property (nonatomic, assign) INSSupportedPluginType topRightPluginType;

@property (nonatomic, assign) INSSupportedPluginType bottomLeftPluginType;

@property (nonatomic, assign) INSSupportedPluginType bottomRightPluginType;

@property (nonatomic, readonly, assign) BOOL isSpecialFontOptionEnabled;

@property (nonatomic, readonly, strong) NSString *specialFontName;

@property (nonatomic, readonly, strong) NSString *specialFontResourcePath;

@property (nonatomic, readonly, assign) BOOL isMusicOptionEnabled;

@property (nonatomic, readonly, strong) NSArray *musicNameArray;

@property (nonatomic, readonly, strong) NSArray *musicUrlPathArray;

@property (nonatomic, assign) NSInteger secondsPerMinute; // 这个字段最终应该为60，为了测试方便，可调整为1.

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)initWithBlock:(void (^)(INSTomatoConfiguration *))configurationBlock;

- (void)enableMusicOptionWithMusicNames:(NSArray *)musicNameArray musicUrlPaths:(NSArray *)musicUrlPathArray;
- (void)enableSpecialFont:(NSString *)fontName resourcePath:(NSString *)resourcePath;

@end

NS_ASSUME_NONNULL_END
