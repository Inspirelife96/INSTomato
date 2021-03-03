//
//  INSBookmarkTablePersistence.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/5.
//

#import "INSBookmarkTablePersistence.h"

#import "INSPersistenceFilePathHelper.h"

#import "INSPersistenceConstants.h"
#import "INSTomatoBundle.h"

NSString *const kBookMarkTablePersistanceFile = @"bookmarkTable.plist";

@implementation INSBookmarkTablePersistence

+ (void)createBookmarkTable {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (24 * 3600)];
    
    UIImage *bookMarkImage = [INSTomatoBundle imageNamed:@"ins_bookmark_default.jpg"];
    
    NSData *imageData = UIImageJPEGRepresentation(bookMarkImage, 0.5);
    
    NSDictionary *bookmarkTableDictionary = @{
                            kBookMarkSavedDate:date,
                            kBookMarkTitle:@"随处可见的醉人景色",
                            kBookMarkWords:@"可以控制自己，并驾驭自己的热忱、欲望及恐惧的人，比国王更有能耐。",
                            kBookMarkImageData:imageData
                            };
    
    [INSBookmarkTablePersistence saveBookmarkTable:bookmarkTableDictionary];
}

+ (NSDictionary *)readBookmarkTable {
    NSString *bookmarkTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kBookMarkTablePersistanceFile];
    return [NSDictionary dictionaryWithContentsOfFile:bookmarkTableFilePath];
}

+ (void)saveBookmarkTable:(NSDictionary *)bookmarkTableDictionary {
    NSString *bookmarkTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kBookMarkTablePersistanceFile];
    [bookmarkTableDictionary writeToFile:bookmarkTableFilePath atomically:YES];
}

+ (void)deleteBookmarkTable {
    NSString *bookmarkTableFilePath = [INSPersistenceFilePathHelper persistenceFilePath:kBookMarkTablePersistanceFile];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:bookmarkTableFilePath error:nil];    
}

@end
