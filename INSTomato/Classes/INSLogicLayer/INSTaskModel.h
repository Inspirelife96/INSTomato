//
//  INSTaskModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 支持的颜色，赤橙黄绿青蓝紫
typedef NS_ENUM(NSInteger, INSSupportedColor) {
    INSSupportedColorRed = 0,
    INSSupportedColorOrange,
    INSSupportedColorYellow,
    INSSupportedColorGreen,
    INSSupportedColorVerdant,
    INSSupportedColorBlue,
    INSSupportedColorPurple
};

// 支持的音乐
typedef NS_ENUM(NSInteger, INSSupportedMusic) {
    INSSupportedMusicChunRan, //纯然
    INSSupportedMusicSenlin,  //森林
    INSSupportedMusicXinling, //心灵
    INSSupportedMusicXingye,  //星夜
    INSSupportedMusicYunduan  //云端
};

typedef NS_ENUM(NSInteger, INSSupportedTomatoMinutes) {
    INSSupportedTomatoMinutes5 = 5,
    INSSupportedTomatoMinutes10 = 10,
    INSSupportedTomatoMinutes15 = 15,
    INSSupportedTomatoMinutes20 = 20,
    INSSupportedTomatoMinutes25 = 25,
    INSSupportedTomatoMinutes30 = 30,
    INSSupportedTomatoMinutes35 = 35,
    INSSupportedTomatoMinutes40 = 40,
    INSSupportedTomatoMinutes45 = 45,
    INSSupportedTomatoMinutes50 = 50,
    INSSupportedTomatoMinutes55 = 55,
    INSSupportedTomatoMinutes60 = 60,
    INSSupportedTomatoMinutes90 = 90,
    INSSupportedTomatoMinutes120 = 120
};

typedef NS_ENUM(NSInteger, INSSupportedRestMinutes) {
    INSSupportedRestMinutes5 = 5,
    INSSupportedRestMinutes10 = 10,
    INSSupportedRestMinutes15 = 15,
    INSSupportedRestMinutes20 = 20,
    INSSupportedRestMinutes25 = 25,
    INSSupportedRestMinutes30 = 30
};

@interface INSTaskModel : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *music;
@property (nonatomic, strong) NSNumber *tomatoMinutes;
@property (nonatomic, strong) NSNumber *restMinutes;
@property (nonatomic, assign) BOOL isFocusModeEnabled;
@property (nonatomic, assign) BOOL isRestModeEnabled;
@property (nonatomic, assign) BOOL isMusicModeEnabled;
@property (nonatomic, assign) BOOL isAlertModeEnabled;
@property (nonatomic, strong) NSDate *alertDate;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTaskName:(NSString *)name;

- (instancetype)initWithTaskName:(NSString *)name colorEnum:(INSSupportedColor)colorEnum;

- (instancetype)initWithTaskName:(NSString *)name colorEnum:(INSSupportedColor)colorEnum musicEnum:(INSSupportedMusic)musicEnum tomatoMinutesEnum:(INSSupportedTomatoMinutes)tomatoMinutesEnum restMinutesEnum:(INSSupportedRestMinutes)restMinutesEnum NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithTaskDictionary:(NSDictionary *)taskDictionary NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)convertToDictionary;

- (BOOL)isEqualToTaskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END
