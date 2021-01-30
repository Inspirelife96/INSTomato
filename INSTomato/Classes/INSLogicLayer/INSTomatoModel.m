//
//  INSTomatoModel.m
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import "INSTomatoModel.h"

#import "INSPersistenceConstants.h"

@implementation INSTomatoModel

- (instancetype)initTaskId:(NSString *)taskId
                 startDate:(NSDate *)startDate
                   endDate:(NSDate *)endDate
                breakTimes:(NSNumber *)breakTimes
             tomatoMinutes:(NSNumber *)tomatoMinutes {
    if (self = [super init]) {
        self.taskId = taskId;
        self.startDate = startDate;
        self.endDate = endDate;
        self.breakTimes = breakTimes;
        self.tomatoMinutes = tomatoMinutes;
    }
    
    return self;
}

- (instancetype)initWithTomatoDictionary:(NSDictionary *)tomatoDictionary {
    if (self = [super init]) {
        self.taskId = tomatoDictionary[kTomatoTableCoreTaskId];
        self.startDate = tomatoDictionary[kTomatoTableCoreStartDate];
        self.endDate = tomatoDictionary[kTomatoTableCoreEndDate];
        self.breakTimes = tomatoDictionary[kTomatoTableCoreBreakTimes];
        self.tomatoMinutes = tomatoDictionary[kTomatoTableCoreTomatoMinutes];
    }
    
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSDictionary *diligenceDictionary = @{
        kTomatoTableCoreTaskId: self.taskId,
        kTomatoTableCoreStartDate: self.startDate,
        kTomatoTableCoreEndDate: self.endDate,
        kTomatoTableCoreBreakTimes: self.breakTimes,
        kTomatoTableCoreTomatoMinutes: self.tomatoMinutes
    };
    
    return diligenceDictionary;
}

@end
