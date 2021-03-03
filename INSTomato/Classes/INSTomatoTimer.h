//
//  INSTomatoTimer.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/2.
//

#import <Foundation/Foundation.h>

#import <AVFoundation/AVFoundation.h>

@class INSTaskModel;

// 当前定时器的状态
// - 运行
// - 暂停
// - 停止
typedef NS_ENUM(NSInteger, INSTomatoTimerStatus) {
    INSTomatoTimerStatusRunning,
    INSTomatoTimerStatusPause,
    INSTomatoTimerStatusStop
};

// 当前的定时器模式
// - 工作模式
// - 休息模式
typedef NS_ENUM(NSInteger, INSTomatoTimerMode) {
    INSTomatoTimerModeWork,
    INSTomatoTimerModeRest
};

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoTimer : NSObject <AVAudioPlayerDelegate>
 
@property(nonatomic, strong) AVAudioPlayer *musicPlayer;
@property(nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) INSTaskModel *taskModel;

@property(nonatomic, strong) NSDate *startDate;

@property(nonatomic, assign) NSInteger totalSeconds;
@property(nonatomic, assign) NSInteger leftSeconds;
@property(nonatomic, assign) NSInteger breakTimes;

@property(nonatomic, assign) INSTomatoTimerStatus tomatoTimerStatus;
@property(nonatomic, assign) INSTomatoTimerMode tomatoTimerMode;

+ (instancetype)sharedInstance;

- (void)startTimer;
- (void)pauseTimer;
- (void)resumeTimer;
- (void)cancelTimer;
- (void)skipTimer;

- (void)updateTomatoTimerWithTaskModel:(INSTaskModel *)taskModel;

@end

NS_ASSUME_NONNULL_END
