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
//NSString *const kTaskTableConfigurationIsAddTaskEnabled = @"isAddTaskEnabled";
//NSString *const kTaskTableConfigurationTitle = @"title";
//NSString *const kTaskTableConfigurationDescription = @"description";
//NSString *const kTaskTableConfigurationIconData = @"icon";

NSString *const kTaskTableCoreIdentifier = @"identifier";
NSString *const kTaskTableCoreName = @"name";
NSString *const kTaskTableCoreColor = @"color";
NSString *const kTaskTableCoreMusic = @"music";
NSString *const kTaskTableCoreTomatoMinutes = @"tomatoMinutes";
NSString *const kTaskTableCoreRestMinutes = @"restMinutes";
NSString *const kTaskTableCoreIsRestModeEnabled = @"isRestModeEnabled";
NSString *const kTaskTableCoreIsMusicModeEnabled = @"isMusicModeEnabled";
NSString *const kTaskTableCoreIsAlertModeEnabled = @"isAlertModeEnabled";
NSString *const kTaskTableCoreAlertDate = @"alertDate";

#pragma mark - tomato table column

NSString *const kStatisticsTableConfiguration = @"configuration";
NSString *const kStatisticsTableCore = @"core";
NSString *const kStatisticsTableTaskIndex = @"taskIndex";
NSString *const kStatisticsTableHourIndex = @"houreIndex";
NSString *const kStatisticsTableDayIndex = @"dayIndex";
NSString *const kStatisticsTableWeekdayIndex = @"weekdayIndex";

#pragma mark - tomato table configuration column

NSString *const kStatisticsTableConfigurationMaxRowId = @"maxRowId";
NSString *const kStatisticsTableConfigurationVersion = @"version";

#pragma mark - tomato table core column
NSString *const kStatisticsTableCoreIdentifier = @"identifier";
NSString *const kStatisticsTableCoreTaskIdentifier = @"taskId";
NSString *const kStatisticsTableCoreStartDate = @"startDate";
NSString *const kStatisticsTableCoreEndDate = @"endDate";
NSString *const kStatisticsTableCoreBreakTimes = @"breakTimes";
NSString *const kStatisticsTableCoreTomatoMinutes = @"tomatoMinutes";

#pragma mark - book mark table column

NSString *const kBookMarkSavedDate = @"date";
NSString *const kBookMarkTitle = @"title";
NSString *const kBookMarkWords = @"words";
NSString *const kBookMarkImageData = @"imageData";

#pragma mark - tomato configuration table column

NSString *const kTomatoConfigurationTableIsAddTaskEnabled = @"isAddTaskEnabled";
NSString *const kTomatoConfigurationTableTitle = @"title";
NSString *const kTomatoConfigurationTableSubTitle = @"subTitle";
NSString *const kTomatoConfigurationTableIconData = @"iconData";
NSString *const kTomatoConfigurationTableBackgroundImageData = @"backgroundImageData";
NSString *const kTomatoConfigurationTablesharedCodeImageData = @"sharedCodeImageData";
NSString *const kTomatoConfigurationTablesharedUrlString = @"sharedUrlString";
NSString *const kTomatoConfigurationTableTopLeftPluginType = @"topLeftPluginType";
NSString *const kTomatoConfigurationTableTopRightPluginType = @"topRightPluginType";
NSString *const kTomatoConfigurationTableBottomLeftPluginType = @"bottomLeftPluginType";
NSString *const kTomatoConfigurationTableBottomRightPluginType = @"bottomRightPluginType";
NSString *const kTomatoConfigurationTableActivedTask = @"activedTask";
NSString *const kTomatoConfigurationTableIsSpecialFontOptionEnabled = @"isSpecialFontOptionEnabled";
NSString *const kTomatoConfigurationTableSpecialFontName = @"specialFontName";
NSString *const kTomatoConfigurationTableSpecialFontResourcePath = @"specialFontResourcePath";
NSString *const kTomatoConfigurationTableIsMusicOptionEnabled = @"isMusicOptionEnabled";
NSString *const kTomatoConfigurationTableMusicNameArray = @"musicNameArray";
NSString *const kTomatoConfigurationTableMusicUrlPathArray = @"musicUrlPathArray";
