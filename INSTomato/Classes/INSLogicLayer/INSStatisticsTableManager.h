//
//  INSStatisticsTableManager.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSStatisticsModel;
@class INSStatisticsTodayModel;
@class INSStatisticsHistoryModel;

@interface INSStatisticsTableManager : NSObject

+ (void)createStatisticsTable;
+ (void)resetStatisticsTable;

+ (instancetype)sharedInstance;

- (void)addTomato:(INSStatisticsModel *)tomatoModel;
- (void)removeTomatoByTaskId:(NSString *)taskId;

- (INSStatisticsTodayModel *)fetchStatisticsTodayModel;
- (INSStatisticsHistoryModel *)fetchStatisticsHistoryModel;

@end

NS_ASSUME_NONNULL_END
