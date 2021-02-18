//
//  INSStatisticsTodayViewModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSStatisticsTodayViewModel.h"

#import "INSStatisticsTodayModel.h"

#import "INSTomatoBundle.h"

@implementation INSStatisticsTodayViewModel

- (instancetype)initWithStatisticsTodayModel:(INSStatisticsTodayModel *)statisticsTodayModel {
    if (self = [super init]) {
        _statisticsTodayModel = statisticsTodayModel;
        _tomatoTimes = [statisticsTodayModel.tomatoTimes stringValue];
        _tomatoMinutes = [statisticsTodayModel.tomatoMinutes stringValue];
        _tomatoQuality = [statisticsTodayModel.tomatoQuality stringValue];
        _tomatoTimesTitle = @"专注次数";
        _tomatoMinutesTitle = @"专注分钟";
        _tomatoQualityTitle = @"专注程度";
        _tomatoTimesImage = [INSTomatoBundle imageNamed:@"redfire_30x30_"];
        _tomatoMinutesImage = [INSTomatoBundle imageNamed:@"yellowclock_30x30_"];
        _tomatoQualityImage = [INSTomatoBundle imageNamed:@"greenheart_30x30_"];
    }
    
    return self;
}

@end
