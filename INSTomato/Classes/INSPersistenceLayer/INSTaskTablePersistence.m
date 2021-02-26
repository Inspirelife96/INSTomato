//
//  INSTaskTablePersistence.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import "INSTaskTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

#import "INSPersistenceConstants.h"

NSString *const kTaskTablePersistanceFile = @"taskTable.plist";

@implementation INSTaskTablePersistence

+ (void)createTaskTable {
    NSDictionary *taskTableDictionary = @{
                                kTaskTableConfiguration:@{
                                        kTaskTableConfigurationMaxRowId:@0,
                                        kTaskTableConfigurationVersion:@"1.0",
                                },
                                kTaskTableCore:@{}
                                };
    
    [INSTaskTablePersistence saveTaskTable:taskTableDictionary];
}

+ (NSDictionary *)readTaskTable {
    NSString *taskTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTaskTablePersistanceFile];
    return [NSDictionary dictionaryWithContentsOfFile:taskTableFilePath];
}

+ (void)saveTaskTable:(NSDictionary *)taskTableDictionary {
    NSString *taskTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTaskTablePersistanceFile];
    [taskTableDictionary writeToFile:taskTableFilePath atomically:YES];
}

+ (void)deleteTaskTable {
    NSString *taskTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTaskTablePersistanceFile];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:taskTableFilePath error:nil];
}

@end
