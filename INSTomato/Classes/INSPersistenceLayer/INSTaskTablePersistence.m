//
//  INSTaskTablePersistence.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import "INSTaskTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

NSString *const kTaskTablePersistanceFile = @"taskTable.plist";

@implementation INSTaskTablePersistence

+ (void)createTaskTable {
    
}

+ (NSDictionary *)readTaskTable {
    NSString *taskTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTaskTablePersistanceFile];
    return [NSDictionary dictionaryWithContentsOfFile:taskTableFilePath];
}

+ (void)saveTaskTable:(NSDictionary *)taskTableDictionary {
    NSString *taskTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTaskTablePersistanceFile];
    [taskTableDictionary writeToFile:taskTableFilePath atomically:YES];
}

@end
