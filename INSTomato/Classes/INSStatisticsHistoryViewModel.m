//
//  INSStatisticsHistoryViewModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSStatisticsHistoryViewModel.h"

#import "INSStatisticsHistoryModel.h"

@implementation INSStatisticsHistoryViewModel

- (instancetype)initWithStatisticsHistoryModel:(INSStatisticsHistoryModel *)statisticsHistoryModel {
    if (self = [super init]) {
        _statisticsHistoryModel = statisticsHistoryModel;
        
        _tomatoTimes = [statisticsHistoryModel.tomatoTimes stringValue];
        _tomatoTimesTitle = @"总专注次数";
        
        _tomatoMinutes = [statisticsHistoryModel.tomatoMinutes stringValue];
        _tomatoMinutesTitle = @"总专注分钟";
        
        _tomatoDays = [statisticsHistoryModel.tomatoDays stringValue];
        _tomatoDaysTitle = @"总专注天数";
        
        _pieChartDataModelArray = statisticsHistoryModel.pieChartDataModelArray;
        
        _barChartDataModelArray = statisticsHistoryModel.barChartDataModelArray;
        
        _bestTask = statisticsHistoryModel.bestTask;
        
        _bestWeekday = statisticsHistoryModel.bestWeekday;
        _bestWeekdayPlus = [NSString stringWithFormat:@"比平常多%@%%", statisticsHistoryModel.bestWeekdayPlus];
        
        _bestHour = statisticsHistoryModel.bestHour;
        _bestHourPlus = [NSString stringWithFormat:@"比平常多%@%%", statisticsHistoryModel.bestHourPlus];
        
        _everageMinutes = [NSString stringWithFormat:@"日均专注%@分钟", statisticsHistoryModel.everageMinutes];
    }
    
    return self;
}

@end
