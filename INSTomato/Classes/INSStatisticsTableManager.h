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

typedef void(^SyncStatisticsToServerBlock)(INSStatisticsModel *statisticsModel);

@interface INSStatisticsTableManager : NSObject

@property (nonatomic, copy) __nullable SyncStatisticsToServerBlock syncStatisticsToServerBlock;

+ (void)createStatisticsTable;
+ (void)resetStatisticsTable;

+ (instancetype)sharedInstance;

- (void)removeAll;
- (void)removeStatisticsByTaskId:(NSString *)taskId;
- (void)addStatistics:(INSStatisticsModel *)statisticsModel;

- (INSStatisticsTodayModel *)fetchStatisticsTodayModel;
- (INSStatisticsHistoryModel *)fetchStatisticsHistoryModel;

@end

NS_ASSUME_NONNULL_END
