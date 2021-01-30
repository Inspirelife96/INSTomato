//
//  INSStatisticsHistoryModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSPieChartDataModel;

@interface INSStatisticsHistoryModel : NSObject

@property (nonatomic, strong) NSNumber *tomatoTimes;
@property (nonatomic, strong) NSNumber *tomatoMinutes;
@property (nonatomic, strong) NSNumber *tomatoDays;

@property (nonatomic, copy) NSString *bestWeekday;
@property (nonatomic, copy) NSString *bestHour;
@property (nonatomic, copy) NSString *bestTask;

@property (nonatomic, strong) NSNumber *bestWeekdayPlus;
@property (nonatomic, strong) NSNumber *bestHourPlus;
@property (nonatomic, strong) NSNumber *everageMinutes;

@property (nonatomic, strong) NSArray<INSPieChartDataModel *>  *pieChartDataModelArray;
@property (nonatomic, strong) NSArray<NSNumber *>  *barChartDataModelArray;

@end

NS_ASSUME_NONNULL_END
