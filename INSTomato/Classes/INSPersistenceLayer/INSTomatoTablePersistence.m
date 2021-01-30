//
//  INSTomatoTablePersistence.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import "INSTomatoTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

#import "INSPersistenceConstants.h"

NSString *const kTomatoTablePersistenceFile = @"tamatoTable.plist";

@implementation INSTomatoTablePersistence

+ (void)createTomatoTable {
    NSDictionary *tomatoTableDictionary = @{
                                kTomatoTableConfiguration:@{
                                        kTomatoTableConfigurationMaxRowId:@0,
                                        kTomatoTableConfigurationVersion:@"1.0"
                                },
                                kTomatoTableCore:@{},
                                kTomatoTableTaskIndex:@{},
                                kTomatoTableHourIndex:@{},
                                kTomatoTableDayIndex:@{},
                                kTomatoTableWeekdayIndex:@{}
                                };
    [INSTomatoTablePersistence saveTomatoTable:tomatoTableDictionary];
}

+ (NSDictionary *)readTomatoTable {
    NSString *tomatoTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTomatoTablePersistenceFile];
    return [NSDictionary dictionaryWithContentsOfFile:tomatoTableFilePath];
}

+ (void)saveTomatoTable:(NSDictionary *)tomatoTableDictionary {
    NSString *tomatoTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTomatoTablePersistenceFile];
    [tomatoTableDictionary writeToFile:tomatoTableFilePath atomically:YES];
}

@end
