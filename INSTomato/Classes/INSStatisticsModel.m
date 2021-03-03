//
//  INSStatisticsModel.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSStatisticsModel.h"

#import "INSPersistenceConstants.h"

@implementation INSStatisticsModel

- (instancetype)initWithTaskId:(NSString *)taskId
                     startDate:(NSDate *)startDate
                       endDate:(NSDate *)endDate
                    breakTimes:(NSNumber *)breakTimes
                 tomatoMinutes:(NSNumber *)tomatoMinutes {
    if (self = [super init]) {
        _identifier = @"";
        _taskId = taskId;
        _startDate = startDate;
        _endDate = endDate;
        _breakTimes = breakTimes;
        _tomatoMinutes = tomatoMinutes;
    }
    
    return self;
}

- (instancetype)initWithTomatoDictionary:(NSDictionary *)tomatoDictionary {
    if (self = [super init]) {
        self.identifier = tomatoDictionary[kStatisticsTableCoreIdentifier],
        self.taskId = tomatoDictionary[kStatisticsTableCoreTaskIdentifier];
        self.startDate = tomatoDictionary[kStatisticsTableCoreStartDate];
        self.endDate = tomatoDictionary[kStatisticsTableCoreEndDate];
        self.breakTimes = tomatoDictionary[kStatisticsTableCoreBreakTimes];
        self.tomatoMinutes = tomatoDictionary[kStatisticsTableCoreTomatoMinutes];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *diligenceDictionary = @{
        kStatisticsTableCoreIdentifier: self.identifier,
        kStatisticsTableCoreTaskIdentifier: self.taskId,
        kStatisticsTableCoreStartDate: self.startDate,
        kStatisticsTableCoreEndDate: self.endDate,
        kStatisticsTableCoreBreakTimes: self.breakTimes,
        kStatisticsTableCoreTomatoMinutes: self.tomatoMinutes
    };
    
    return diligenceDictionary;
}

@end
