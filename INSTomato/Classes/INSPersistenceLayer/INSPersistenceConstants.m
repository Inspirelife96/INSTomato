//
//  INSPersistenceConstants.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>


NSString *const kTaskTableConfiguration = @"configuration";
NSString *const kTaskTableCore = @"core";

NSString *const kTaskTableConfigurationMaxRowId = @"maxRowId";
NSString *const kTaskTableConfigurationVersion = @"version";

NSString *const kTaskTableCoreIdentifier = @"identifier";
NSString *const kTaskTableCoreName = @"name";
NSString *const kTaskTableCoreColor = @"color";
NSString *const kTaskTableCoreMusic = @"music";
NSString *const kTaskTableCoreTomatoMinutes = @"tomatoMinutes";
NSString *const kTaskTableCoreRestMinutes = @"restMinutes";
NSString *const kTaskTableCoreIsFocusModeEnabled = @"isFocusModeEnabled";
NSString *const kTaskTableCoreIsRestModeEnabled = @"isRestModeEnabled";
NSString *const kTaskTableCoreIsMusicModeEnabled = @"isMusicModeEnabled";
NSString *const kTaskTableCoreIsAlertModeEnabled = @"isAlertModeEnabled";
NSString *const kTaskTableCoreAlertDate = @"alertDate";

#pragma mark - tomato table column

NSString *const kTomatoTableConfiguration = @"configuration";
NSString *const kTomatoTableCore = @"core";
NSString *const kTomatoTableTaskIndex = @"taskIndex";
NSString *const kTomatoTableHourIndex = @"houreIndex";
NSString *const kTomatoTableDayIndex = @"dayIndex";
NSString *const kTomatoTableWeekdayIndex = @"weekdayIndex";

#pragma mark - tomato table configuration column

NSString *const kTomatoTableConfigurationMaxRowId = @"maxRowId";
NSString *const kTomatoTableConfigurationVersion = @"version";

#pragma mark - tomato table core column

NSString *const kTomatoTableCoreTaskId = @"taskId";
NSString *const kTomatoTableCoreStartDate = @"startDate";
NSString *const kTomatoTableCoreEndDate = @"endDate";
NSString *const kTomatoTableCoreBreakTimes = @"breakTimes";
NSString *const kTomatoTableCoreTomatoMinutes = @"tomatoMinutes";
