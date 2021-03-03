//
//  INSStatisticsHistoryViewModel.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import <Foundation/Foundation.h>

@class INSStatisticsHistoryModel;
@class INSPieChartDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSStatisticsHistoryViewModel : NSObject

// 总专注次数
@property (nonatomic, copy) NSString *tomatoTimes;
@property (nonatomic, copy) NSString *tomatoTimesTitle;

// 总专注分钟
@property (nonatomic, copy) NSString *tomatoMinutes;
@property (nonatomic, copy) NSString *tomatoMinutesTitle;

// 总专注天数
@property (nonatomic, copy) NSString *tomatoDays;
@property (nonatomic, copy) NSString *tomatoDaysTitle;

// 饼图数据
@property (nonatomic, strong) NSArray<INSPieChartDataModel *>  *pieChartDataModelArray;

// 柱状图数据
@property (nonatomic, strong) NSArray<NSNumber *>  *barChartDataModelArray;

// 最佳专注任务
@property (nonatomic, copy) NSString *bestTask;

// 最佳星期日
@property (nonatomic, copy) NSString *bestWeekday;
@property (nonatomic, copy) NSString *bestWeekdayPlus;

// 最佳时段
@property (nonatomic, copy) NSString *bestHour;
@property (nonatomic, copy) NSString *bestHourPlus;

// 平均数据
@property (nonatomic, copy) NSString *everageMinutes;

// 模型
@property (nonatomic, strong) INSStatisticsHistoryModel *statisticsHistoryModel;

- (instancetype)initWithStatisticsHistoryModel:(INSStatisticsHistoryModel *)statisticsHistoryModel;

@end

NS_ASSUME_NONNULL_END
