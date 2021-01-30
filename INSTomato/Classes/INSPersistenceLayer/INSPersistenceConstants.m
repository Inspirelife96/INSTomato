//
//  INSPersistenceConstants.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>

NSString *const kTaskTableName = @"name";
NSString *const kTaskTableColor = @"color";
NSString *const kTaskTableMusic = @"music";
NSString *const kTaskTableTomatoMinutes = @"tomatoMinutes";
NSString *const kTaskTableRestMinutes = @"restMinutes";
NSString *const kTaskTableIsFocusModeEnabled = @"isFocusModeEnabled";
NSString *const kTaskTableIsRestModeEnabled = @"isRestModeEnabled";
NSString *const kTaskTableIsMusicModeEnabled = @"isMusicModeEnabled";
NSString *const kTaskTableIsAlertModeEnabled = @"isAlertModeEnabled";
NSString *const kTaskTableAlertDate = @"alertDate";

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
