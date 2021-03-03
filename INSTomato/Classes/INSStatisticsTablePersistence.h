//
//  INSStatisticsTablePersistence.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSStatisticsTablePersistence : NSObject

+ (void)createStatisticsTable;
+ (NSDictionary *)readStatisticsTable;
+ (void)saveStatisticsTable:(NSDictionary *)statisticsTableDictionary;
+ (void)deleteStatisticsTable;

@end

NS_ASSUME_NONNULL_END
