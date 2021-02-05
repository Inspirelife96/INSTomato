//
//  INSPersistenceConstants.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#ifndef INSPersistenceConstants_h
#define INSPersistenceConstants_h

#pragma mark - task table column

extern NSString *const kTaskTableConfiguration;
extern NSString *const kTaskTableCore;

extern NSString *const kTaskTableConfigurationMaxRowId;
extern NSString *const kTaskTableConfigurationVersion;

extern NSString *const kTaskTableCoreIdentifier;
extern NSString *const kTaskTableCoreName;
extern NSString *const kTaskTableCoreColor;
extern NSString *const kTaskTableCoreMusic;
extern NSString *const kTaskTableCoreTomatoMinutes;
extern NSString *const kTaskTableCoreRestMinutes;
extern NSString *const kTaskTableCoreIsFocusModeEnabled;
extern NSString *const kTaskTableCoreIsRestModeEnabled;
extern NSString *const kTaskTableCoreIsMusicModeEnabled;
extern NSString *const kTaskTableCoreIsAlertModeEnabled;
extern NSString *const kTaskTableCoreAlertDate;

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


#pragma mark - book mark table column

extern NSString *const kBookMarkDate;
extern NSString *const kBookMarkTitle;
extern NSString *const kBookMarkWords;
extern NSString *const kBookMarkImageData;

#endif /* INSPersistenceConstants_h */
