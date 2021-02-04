//
//  INSTaskModel.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTaskModel.h"

#import "INSPersistenceConstants.h"

@implementation INSTaskModel

- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name color:(NSString *)color music:(NSString *)music {
    if (self = [super init]) {
        self.identifier = identifier;
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
        self.identifier = taskDictionary[kTaskTableCoreIdentifier];
        self.name = taskDictionary[kTaskTableCoreName];
        self.color = taskDictionary[kTaskTableCoreColor];
        self.music = taskDictionary[kTaskTableCoreMusic];
        self.tomatoMinutes = taskDictionary[kTaskTableCoreTomatoMinutes];
        self.restMinutes = taskDictionary[kTaskTableCoreRestMinutes];
        self.isFocusModeEnabled = [taskDictionary[kTaskTableCoreIsFocusModeEnabled] boolValue];
        self.isRestModeEnabled = [taskDictionary[kTaskTableCoreIsRestModeEnabled] boolValue];
        self.isMusicModeEnabled = [taskDictionary[kTaskTableCoreIsMusicModeEnabled] boolValue];
        self.isAlertModeEnabled = [taskDictionary[kTaskTableCoreIsAlertModeEnabled] boolValue];
        self.alertDate = taskDictionary[kTaskTableCoreAlertDate];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *taskDictionary = @{
        kTaskTableCoreIdentifier: self.identifier,
        kTaskTableCoreName: self.name,
        kTaskTableCoreColor: self.color,
        kTaskTableCoreMusic: self.music,
        kTaskTableCoreTomatoMinutes: self.tomatoMinutes,
        kTaskTableCoreRestMinutes: self.restMinutes,
        kTaskTableCoreIsFocusModeEnabled: [NSNumber numberWithBool:self.isFocusModeEnabled],
        kTaskTableCoreIsRestModeEnabled: [NSNumber numberWithBool:self.isRestModeEnabled],
        kTaskTableCoreIsMusicModeEnabled: [NSNumber numberWithBool:self.isMusicModeEnabled],
        kTaskTableCoreIsAlertModeEnabled: [NSNumber numberWithBool:self.isAlertModeEnabled],
        kTaskTableCoreAlertDate: self.alertDate
    };
    
    return taskDictionary;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    INSTaskModel *taskModel = [[[self class] allocWithZone:zone] init];
    taskModel.identifier = [self.identifier copy];
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
    
    if ([self.identifier isEqualToString:taskModel.identifier] &&
        [self.name isEqualToString:taskModel.name] &&
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
