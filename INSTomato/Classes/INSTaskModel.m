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
        self.identifier = @"";
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
    }
    
    return self;
}

//- (instancetype)initWithIdentifier:(NSString *)identifier name:(NSString *)name color:(NSString *)color music:(NSString *)music {
//    if (self = [super init]) {
//        self.identifier = identifier;
//        self.name = name;
//        self.color = color;
//        self.music = music;
//        self.tomatoMinutes = @25;
//        self.restMinutes = @5;
//        self.isFocusModeEnabled = NO;
//        self.isRestModeEnabled = YES;
//        self.isMusicModeEnabled = YES;
//        self.isAlertModeEnabled = NO;
//        self.alertDate = [NSDate dateWithTimeIntervalSince1970:10 * 3600];
//    }
//
//    return self;
//}

- (instancetype)initWithTaskDictionary:(NSDictionary *)taskDictionary {
    if (self = [super init]) {
        self.identifier = taskDictionary[kTaskTableCoreIdentifier];
        self.name = taskDictionary[kTaskTableCoreName];
        self.color = taskDictionary[kTaskTableCoreColor];
        self.music = taskDictionary[kTaskTableCoreMusic];
        self.tomatoMinutes = taskDictionary[kTaskTableCoreTomatoMinutes];
        self.restMinutes = taskDictionary[kTaskTableCoreRestMinutes];
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
