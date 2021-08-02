//
//  INSTaskModel.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskModel.h"

#import "INSPersistenceConstants.h"

#import "INSColorHelper.h"

@implementation INSTaskModel

- (instancetype)initWithTaskName:(NSString *)name {
    return [self initWithTaskName:name musicName:@"" colorEnum:INSSupportedColorRed tomatoMinutesEnum:INSSupportedTomatoMinutes25 restMinutesEnum:INSSupportedRestMinutes5];
}

- (instancetype)initWithTaskName:(NSString *)name musicName:(NSString *)musicName {
    return [self initWithTaskName:name musicName:name colorEnum:INSSupportedColorRed tomatoMinutesEnum:INSSupportedTomatoMinutes25 restMinutesEnum:INSSupportedRestMinutes5];
}

- (instancetype)initWithTaskName:(NSString *)name  colorEnum:(INSSupportedColor)colorEnum {
    return [self initWithTaskName:name musicName:@"" colorEnum:colorEnum tomatoMinutesEnum:INSSupportedTomatoMinutes25 restMinutesEnum:INSSupportedRestMinutes5];
}

- (instancetype)initWithTaskName:(NSString *)name musicName:(NSString *)musicName colorEnum:(INSSupportedColor)colorEnum {
    return [self initWithTaskName:name musicName:musicName colorEnum:colorEnum tomatoMinutesEnum:INSSupportedTomatoMinutes25 restMinutesEnum:INSSupportedRestMinutes5];
}

- (instancetype)initWithTaskName:(NSString *)name musicName:(NSString *)musicName colorEnum:(INSSupportedColor)colorEnum tomatoMinutesEnum:(INSSupportedTomatoMinutes)tomatoMinutesEnum restMinutesEnum:(INSSupportedRestMinutes)restMinutesEnum {
    if (self = [super init]) {
        self.taskId = [[NSUUID UUID] UUIDString];
        self.name = name;
        self.color = [INSColorHelper colorNameList][colorEnum];
        self.music = musicName;
        self.tomatoMinutes = @(tomatoMinutesEnum);
        self.restMinutes = @(restMinutesEnum);
        self.isFocusModeEnabled = NO;
        self.isRestModeEnabled = YES;
        
        if (musicName && ![musicName isEqualToString:@""]) {
            self.isMusicModeEnabled = YES;
        } else {
            self.isMusicModeEnabled = NO;
        }
        
        self.isAlertModeEnabled = NO;
        self.alertDate = [NSDate dateWithTimeIntervalSince1970:10 * 3600];
        
        NSDate *date = [NSDate date];
        
        NSTimeInterval timeInterval = [date timeIntervalSince1970] * 1000000;
        
        self.sortId = [NSString stringWithFormat:@"%llu", (long long unsigned)timeInterval];
    }
    
    return self;
}

- (instancetype)initWithTaskDictionary:(NSDictionary *)taskDictionary {
    if (self = [super init]) {
        self.taskId = taskDictionary[kTaskTableCoreIdentifier];
        self.name = taskDictionary[kTaskTableCoreName];
        self.color = taskDictionary[kTaskTableCoreColor];
        self.music = taskDictionary[kTaskTableCoreMusic];
        self.tomatoMinutes = taskDictionary[kTaskTableCoreTomatoMinutes];
        self.restMinutes = taskDictionary[kTaskTableCoreRestMinutes];
        self.isRestModeEnabled = [taskDictionary[kTaskTableCoreIsRestModeEnabled] boolValue];
        self.isFocusModeEnabled = [taskDictionary[kTaskTableCoreIsFocusModeEnabled] boolValue];
        self.isMusicModeEnabled = [taskDictionary[kTaskTableCoreIsMusicModeEnabled] boolValue];
        self.isAlertModeEnabled = [taskDictionary[kTaskTableCoreIsAlertModeEnabled] boolValue];
        self.alertDate = taskDictionary[kTaskTableCoreAlertDate];
        self.sortId = taskDictionary[kTaskTableCoreSortId];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *taskDictionary = @{
        kTaskTableCoreIdentifier: self.taskId,
        kTaskTableCoreName: self.name,
        kTaskTableCoreColor: self.color,
        kTaskTableCoreMusic: self.music,
        kTaskTableCoreTomatoMinutes: self.tomatoMinutes,
        kTaskTableCoreRestMinutes: self.restMinutes,
        kTaskTableCoreIsRestModeEnabled: [NSNumber numberWithBool:self.isRestModeEnabled],
        kTaskTableCoreIsFocusModeEnabled: [NSNumber numberWithBool:self.isFocusModeEnabled],
        kTaskTableCoreIsMusicModeEnabled: [NSNumber numberWithBool:self.isMusicModeEnabled],
        kTaskTableCoreIsAlertModeEnabled: [NSNumber numberWithBool:self.isAlertModeEnabled],
        kTaskTableCoreAlertDate: self.alertDate,
        kTaskTableCoreSortId: self.sortId
    };
    
    return taskDictionary;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    INSTaskModel *taskModel = [[[self class] allocWithZone:zone] init];
    taskModel.taskId = [self.taskId copy];
    taskModel.name = [self.name copy];
    taskModel.color = [self.color copy];
    taskModel.music = [self.music copy];
    taskModel.tomatoMinutes = [self.tomatoMinutes copy];
    taskModel.restMinutes = [self.restMinutes copy];
    taskModel.isFocusModeEnabled = self.isFocusModeEnabled;
    taskModel.isRestModeEnabled = self.isRestModeEnabled;
    taskModel.isMusicModeEnabled = self.isMusicModeEnabled;
    taskModel.isAlertModeEnabled = self.isAlertModeEnabled;
    taskModel.alertDate = [self.alertDate copy];
    taskModel.sortId = [self.sortId copy];
    
    return taskModel;
}

- (BOOL)isEqualToTaskModel:(INSTaskModel *)taskModel {
    if (self == taskModel) {
        return YES;
    }
    
    if ([self.taskId isEqualToString:taskModel.taskId] &&
        [self.name isEqualToString:taskModel.name] &&
        [self.color isEqualToString:taskModel.color] &&
        [self.music isEqualToString:taskModel.music] &&
        [self.tomatoMinutes isEqualToNumber:taskModel.tomatoMinutes] &&
        [self.restMinutes isEqualToNumber:taskModel.restMinutes] &&
        self.isFocusModeEnabled == taskModel.isFocusModeEnabled &&
        self.isRestModeEnabled == taskModel.isRestModeEnabled &&
        self.isMusicModeEnabled == taskModel.isMusicModeEnabled &&
        self.isAlertModeEnabled == taskModel.isAlertModeEnabled &&
        [self.alertDate isEqualToDate:taskModel.alertDate] &&
        [self.sortId isEqualToString:taskModel.sortId]) {
        return YES;
    }
    
    return NO;
}

@end
