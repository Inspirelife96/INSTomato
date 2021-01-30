//
//  INSPersistenceConstants.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#ifndef INSPersistenceConstants_h
#define INSPersistenceConstants_h

#pragma mark - task table column

extern NSString *const kTaskTableName;
extern NSString *const kTaskTableColor;
extern NSString *const kTaskTableMusic;
extern NSString *const kTaskTableTomatoMinutes;
extern NSString *const kTaskTableRestMinutes;
extern NSString *const kTaskTableIsFocusModeEnabled;
extern NSString *const kTaskTableIsRestModeEnabled;
extern NSString *const kTaskTableIsMusicModeEnabled;
extern NSString *const kTaskTableIsAlertModeEnabled;
extern NSString *const kTaskTableAlertDate;

#pragma mark - tomato table column

extern NSString *const kTomatoTableConfiguration;
extern NSString *const kTomatoTableCore;
extern NSString *const kTomatoTableTaskIndex;
extern NSString *const kTomatoTableHourIndex;
extern NSString *const kTomatoTableDayIndex;
extern NSString *const kTomatoTableWeekdayIndex;

#pragma mark - tomato table configuration column

extern NSString *const kTomatoTableConfigurationMaxRowId;
extern NSString *const kTomatoTableConfigurationVersion;

#pragma mark - tomato table core column

extern NSString *const kTomatoTableCoreTaskId;
extern NSString *const kTomatoTableCoreStartDate;
extern NSString *const kTomatoTableCoreEndDate;
extern NSString *const kTomatoTableCoreBreakTimes;
extern NSString *const kTomatoTableCoreTomatoMinutes;

#endif /* INSPersistenceConstants_h */
