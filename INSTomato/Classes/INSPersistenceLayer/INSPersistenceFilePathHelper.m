//
//  INSPersistenceFilePathHelper.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import "INSPersistenceFilePathHelper.h"

@implementation INSPersistenceFilePathHelper

+ (NSString *)persistenceFilePath:(NSString *)persistenceFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    return [documentPath stringByAppendingPathComponent:persistenceFileName];
}

@end
