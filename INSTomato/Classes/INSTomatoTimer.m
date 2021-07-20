//
//  INSTomatoTimer.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/2.
//

#import "INSTomatoTimer.h"

#import "INSNotificationConstants.h"

#import "INSTaskModel.h"
#import "INSStatisticsModel.h"

#import "INSStatisticsTableManager.h"
#import "INSTomatoConfigurationTableManager.h"

#define TIMER_INTERVAL 1
#define SECONDS_PER_MINUTE 60

@implementation INSTomatoTimer

static INSTomatoTimer * _tomatoTimer = nil;

+ (instancetype)allocWithZone:(NSZone *)zone {
    return [INSTomatoTimer sharedInstance];
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tomatoTimer = [[super allocWithZone:nil] init];
        
        _tomatoTimer.tomatoTimerStatus = INSTomatoTimerStatusStop;
        _tomatoTimer.tomatoTimerMode = INSTomatoTimerModeWork;
    });
    return _tomatoTimer;
}

- (void)updateTomatoTimerWithTaskModel:(INSTaskModel *)taskModel {
    _taskModel = taskModel;
    
    _tomatoTimer.tomatoTimerStatus = INSTomatoTimerStatusStop;
    _tomatoTimer.tomatoTimerMode = INSTomatoTimerModeWork;
    
    _tomatoTimer.totalSeconds = [self.taskModel.tomatoMinutes integerValue] * SECONDS_PER_MINUTE;
    _tomatoTimer.leftSeconds = _tomatoTimer.totalSeconds;
    _tomatoTimer.breakTimes = 0;
    
    [[INSTomatoConfigurationTableManager sharedInstance] configActivedTask:taskModel];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [INSTomatoTimer sharedInstance];
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone {
    return [INSTomatoTimer sharedInstance];
}

- (void)startTimer {
    if (self.tomatoTimerStatus == INSTomatoTimerStatusStop) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        self.tomatoTimerStatus = INSTomatoTimerStatusRunning;
        _startDate = [NSDate date];
        
        if (self.taskModel.isMusicModeEnabled == YES) {
            NSURL *musicUrl = [[INSTomatoConfigurationTableManager sharedInstance] musicUrlForMusicName:self.taskModel.music];
            self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
            self.musicPlayer.delegate = self;
            self.musicPlayer.numberOfLoops = -1;
            self.musicPlayer.volume = 1;
            self.musicPlayer.meteringEnabled = YES;

            [self.musicPlayer prepareToPlay];
            [self.musicPlayer play];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerStart object:nil];
    }
}

- (void)pauseTimer {
    if (self.tomatoTimerStatus == INSTomatoTimerStatusRunning) {
        [self.timer setFireDate:[NSDate distantFuture]];
        self.tomatoTimerStatus = INSTomatoTimerStatusPause;
        
        if (self.taskModel.isMusicModeEnabled == YES) {
            [self.musicPlayer pause];
        }
        
        _breakTimes++;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerPause object:nil];
    }
}

- (void)resumeTimer {
    if (self.tomatoTimerStatus == INSTomatoTimerStatusPause) {
        [self.timer setFireDate:[NSDate distantPast]];
        self.tomatoTimerStatus = INSTomatoTimerStatusRunning;
        
        if (self.taskModel.isMusicModeEnabled == YES) {
            [self.musicPlayer play];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerResume object:nil];
    }
}

- (void)cancelTimer {
    [self.timer invalidate];
    
    self.tomatoTimerStatus = INSTomatoTimerStatusStop;
    self.tomatoTimerMode = INSTomatoTimerModeWork;
    self.totalSeconds = [self.taskModel.tomatoMinutes integerValue] * SECONDS_PER_MINUTE;
    self.leftSeconds = _tomatoTimer.totalSeconds;
    _breakTimes = 0;
    
    if (self.taskModel.isMusicModeEnabled == YES) {
        [self.musicPlayer stop];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerCancel object:nil];
}

- (void)skipTimer {
    [self.timer invalidate];
    
    self.tomatoTimerStatus = INSTomatoTimerStatusStop;
    self.tomatoTimerMode = INSTomatoTimerModeWork;
    self.totalSeconds = [self.taskModel.tomatoMinutes integerValue] * SECONDS_PER_MINUTE;
    self.leftSeconds = self.totalSeconds;
    _breakTimes = 0;
    
    if (self.taskModel.isMusicModeEnabled == YES) {
        [self.musicPlayer stop];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerSkip object:nil];
}

- (void)updateProgress {
    if (self.leftSeconds > 0) {
        self.leftSeconds -= TIMER_INTERVAL;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerUpdate object:nil];
    } else {
        //每当一个番茄/休息完成，要做的事情
        // 1. 停止闹钟
        // 2. 如果音乐开启，停止音乐
        // 3. 发送结束音
        // 4. 切换状态为INSTomatoTimerStatusStop
        // 5. 切换到下一个番茄/休息的初始状态
        // 6. 一切完成后，发送通知
        [self.timer invalidate];
        
        if (self.taskModel.isMusicModeEnabled == YES) {
            [self.musicPlayer stop];
        }
        
        [self playSystemSound];
        
        self.tomatoTimerStatus = INSTomatoTimerStatusStop;
        
        // 如果当前是工作模式，那么必须记录数据，并且根据休息模式是否启动，切换
        // 否则，直接切换到工作模式
        if (self.tomatoTimerMode == INSTomatoTimerModeWork) {
            [self saveTomatoData];
            
            if (self.taskModel.isRestModeEnabled) {
                _tomatoTimerMode = INSTomatoTimerModeRest;
                _totalSeconds = [self.taskModel.restMinutes integerValue] * SECONDS_PER_MINUTE;
            } else {
                _tomatoTimerMode = INSTomatoTimerModeWork;
                _totalSeconds = [self.taskModel.tomatoMinutes integerValue] * SECONDS_PER_MINUTE;;
            }
        } else {
            _tomatoTimerMode = INSTomatoTimerModeWork;
            _totalSeconds = [self.taskModel.tomatoMinutes integerValue] * SECONDS_PER_MINUTE;
        }

        _leftSeconds = self.totalSeconds;

        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTomatoTimerComplete object:nil];
    }
}

- (void)saveTomatoData {
    INSStatisticsModel *statisticsModel = [[INSStatisticsModel alloc] initWithTaskId:self.taskModel.taskId startDate:self.startDate endDate:[NSDate date] breakTimes:[NSNumber numberWithInteger:self.breakTimes] tomatoMinutes:self.taskModel.tomatoMinutes];
    
    [[INSStatisticsTableManager sharedInstance] addStatistics:statisticsModel];
    
    if ([INSStatisticsTableManager sharedInstance].syncStatisticsToServerBlock) {
        [INSStatisticsTableManager sharedInstance].syncStatisticsToServerBlock(statisticsModel);
    }
}

- (void)playSystemSound {
    SystemSoundID sound = kSystemSoundID_Vibrate;
    
    //这里使用在上面那个网址找到的铃声，注意格式
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"new-mail",@"caf"];
    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        if (error != kAudioServicesNoError) {
            sound = 0;
        }
    }
    
    AudioServicesPlaySystemSound(sound);//播放声音
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//静音模式下震动
}

@end
