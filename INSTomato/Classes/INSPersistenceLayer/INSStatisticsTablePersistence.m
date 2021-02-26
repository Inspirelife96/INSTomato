//
//  INSStatisticsTablePersistence.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import "INSStatisticsTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

#import "INSPersistenceConstants.h"

NSString *const kStatisticsTablePersistenceFile = @"statisticsTable.plist";

@implementation INSStatisticsTablePersistence

+ (void)createStatisticsTable {
    NSDictionary *statisticsTableDictionary = @{
                                kStatisticsTableConfiguration:@{
                                        kStatisticsTableConfigurationMaxRowId:@0,
                                        kStatisticsTableConfigurationVersion:@"1.0"
                                },
                                kStatisticsTableCore:@{},
                                kStatisticsTableTaskIndex:@{},
                                kStatisticsTableHourIndex:@{},
                                kStatisticsTableDayIndex:@{},
                                kStatisticsTableWeekdayIndex:@{}
                                };
    [INSStatisticsTablePersistence saveStatisticsTable:statisticsTableDictionary];
}

+ (NSDictionary *)readStatisticsTable {
    NSString *statisticsTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kStatisticsTablePersistenceFile];
    return [NSDictionary dictionaryWithContentsOfFile:statisticsTableFilePath];
}

+ (void)saveStatisticsTable:(NSDictionary *)statisticsTableDictionary {
    NSString *statisticsTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kStatisticsTablePersistenceFile];
    [statisticsTableDictionary writeToFile:statisticsTableFilePath atomically:YES];
}

+ (void)deleteStatisticsTable {
    NSString *statisticsTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kStatisticsTablePersistenceFile];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:statisticsTableFilePath error:nil];
}

@end
