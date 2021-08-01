//
//  INSTomatoConfigurationTablePersistence.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/22.
//

#import "INSTomatoConfigurationTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

#import "INSPersistenceConstants.h"

#import "INSTomatoBundle.h"

NSString *const kTomatoConfigurationTablePersistenceFile = @"tamatoConfigurationTable.plist";

@implementation INSTomatoConfigurationTablePersistence

+ (void)createTomatoConfigurationTable {
    NSDictionary *tomatoConfigurationTableDictionary = @{
        kTomatoConfigurationTableIsAddTaskEnabled:@(YES),
        kTomatoConfigurationTableTitle:@"",
        kTomatoConfigurationTableSubTitle:@"",
        kTomatoConfigurationTableIconData:[[NSData alloc] init],
        kTomatoConfigurationTableBackgroundImageData:[[NSData alloc] init],
        kTomatoConfigurationTablesharedCodeImageData:[[NSData alloc] init],
        kTomatoConfigurationTablesharedUrlString:@"",
        kTomatoConfigurationTableTopLeftPluginType:@(1),
        kTomatoConfigurationTableTopRightPluginType:@(2),
        kTomatoConfigurationTableBottomLeftPluginType:@(3),
        kTomatoConfigurationTableBottomRightPluginType:@(4),
        kTomatoConfigurationTableIsSpecialFontOptionEnabled:@(NO),
        kTomatoConfigurationTableSpecialFontName:@"",
        kTomatoConfigurationTableSpecialFontResourcePath:@"",
        kTomatoConfigurationTableIsMusicOptionEnabled:@(NO),
        kTomatoConfigurationTableMusicNameArray:@[],
        kTomatoConfigurationTableMusicUrlPathArray:@[],
        kTomatoConfigurationTableSecondsPerMinute:@(60),
    };
    
    [INSTomatoConfigurationTablePersistence saveTomatoConfigurationTable:tomatoConfigurationTableDictionary];
}

+ (NSDictionary *)readTomatoConfigurationTable {
    NSString *tomatoConfigurationTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTomatoConfigurationTablePersistenceFile];
    return [NSDictionary dictionaryWithContentsOfFile:tomatoConfigurationTableFilePath];
}

+ (void)saveTomatoConfigurationTable:(NSDictionary *)tomatoConfigurationTableDictionary {
    NSString *tomatoConfigurationTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTomatoConfigurationTablePersistenceFile];
    [tomatoConfigurationTableDictionary writeToFile:tomatoConfigurationTableFilePath atomically:YES];
}

+ (void)deleteTomatoConfigurationTable {
    NSString *tomatoConfigurationTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kTomatoConfigurationTablePersistenceFile];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:tomatoConfigurationTableFilePath error:nil];
}

@end
