//
//  INSTaskModel.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskModel.h"

#import "INSPersistenceConstants.h"

@implementation INSTaskModel

- (instancetype)initWithName:(NSString *)name color:(NSString *)color music:(NSString *)music {
    if (self = [super init]) {
        self.name = name;
        self.color = color;
        self.music = music;
        self.tomatoMinutes = @25;
        self.restMinutes = @5;
        self.isFocusModeEnabled = NO;
        self.isRestModeEnabled = YES;
        self.isMusicModeEnabled = YES;
        self.isAlertModeEnabled = NO;
        self.alertDate = [NSDate dateWithTimeIntervalSince1970:10 * 3600];
    }
    
    return self;
}

- (instancetype)initWithTaskDictionary:(NSDictionary *)taskDictionary {
    if (self = [super init]) {
        self.name = taskDictionary[kTaskTableName];
        self.color = taskDictionary[kTaskTableColor];
        self.music = taskDictionary[kTaskTableMusic];
        self.tomatoMinutes = taskDictionary[kTaskTableTomatoMinutes];
        self.restMinutes = taskDictionary[kTaskTableRestMinutes];
        self.isFocusModeEnabled = [taskDictionary[kTaskTableIsFocusModeEnabled] boolValue];
        self.isRestModeEnabled = [taskDictionary[kTaskTableIsRestModeEnabled] boolValue];
        self.isMusicModeEnabled = [taskDictionary[kTaskTableIsMusicModeEnabled] boolValue];
        self.isAlertModeEnabled = [taskDictionary[kTaskTableIsAlertModeEnabled] boolValue];
        self.alertDate = taskDictionary[kTaskTableAlertDate];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *taskDictionary = @{
        kTaskTableName: self.name,
        kTaskTableColor: self.color,
        kTaskTableMusic: self.music,
        kTaskTableTomatoMinutes: self.tomatoMinutes,
        kTaskTableRestMinutes: self.restMinutes,
        kTaskTableIsFocusModeEnabled: [NSNumber numberWithBool:self.isRestModeEnabled],
        kTaskTableIsRestModeEnabled: [NSNumber numberWithBool:self.isFocusModeEnabled],
        kTaskTableIsMusicModeEnabled: [NSNumber numberWithBool:self.isMusicModeEnabled],
        kTaskTableIsAlertModeEnabled: [NSNumber numberWithBool:self.isAlertModeEnabled],
        kTaskTableAlertDate: self.alertDate
    };
    
    return taskDictionary;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    INSTaskModel *taskModel = [[[self class] allocWithZone:zone] init];
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
    
    return taskModel;
}

- (BOOL)isEqualToTaskModel:(INSTaskModel *)taskModel {
    if (self == taskModel) {
        return YES;
    }
    
    if ([self.name isEqualToString:taskModel.name] &&
        [self.color isEqualToString:taskModel.color] &&
        [self.music isEqualToString:taskModel.music] &&
        [self.tomatoMinutes isEqualToNumber:taskModel.tomatoMinutes] &&
        [self.restMinutes isEqualToNumber:taskModel.restMinutes] &&
        self.isFocusModeEnabled == taskModel.isFocusModeEnabled &&
        self.isRestModeEnabled == taskModel.isRestModeEnabled &&
        self.isMusicModeEnabled == taskModel.isMusicModeEnabled &&
        self.isAlertModeEnabled == taskModel.isAlertModeEnabled &&
        [self.alertDate isEqualToDate:taskModel.alertDate]) {
        return YES;
    }
    
    return NO;
}

@end
