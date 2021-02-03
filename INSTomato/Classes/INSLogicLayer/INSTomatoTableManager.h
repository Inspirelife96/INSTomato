//
//  INSTomatoTableManager.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSTomatoModel;
@class INSStatisticsTodayModel;
@class INSStatisticsHistoryModel;

@interface INSTomatoTableManager : NSObject

+ (void)createTomatoTable;
+ (instancetype)sharedInstance;

- (void)addTomato:(INSTomatoModel *)tomatoModel;
- (void)removeTomatoByTaskId:(NSString *)taskId;

- (INSStatisticsTodayModel *)fetchStatisticsTodayModel;
- (INSStatisticsHistoryModel *)fetchStatisticsHistoryModel;

@end

NS_ASSUME_NONNULL_END
