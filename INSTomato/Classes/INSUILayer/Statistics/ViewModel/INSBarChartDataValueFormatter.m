//
//  INSBarChartDataValueFormatter.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/7.
//

#import "INSBarChartDataValueFormatter.h"



@interface INSBarChartDataValueFormatter () {
    NSDateFormatter *_dateFormatter;
}
@end

@implementation INSBarChartDataValueFormatter

- (instancetype)init {
    if (self = [super init]) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"MM-dd";
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-(value * 3600 * 24)];
    return [_dateFormatter stringFromDate:date];
}

@end
