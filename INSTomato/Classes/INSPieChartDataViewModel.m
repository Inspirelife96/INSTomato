//
//  INSPieChartDataViewModel.m
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import "INSPieChartDataViewModel.h"

#import "INSPieChartDataModel.h"

#import "INSColorHelper.h"

@implementation INSPieChartDataViewModel

- (instancetype)initWithPieChartDataModel:(INSPieChartDataModel *)pieChartDataModel {
    if (self = [super init]) {
        _taskName = pieChartDataModel.taskName;
        _tomatoMinutes = [pieChartDataModel.tomatoMinutes doubleValue];
        _taskColor = [INSColorHelper colorByName:pieChartDataModel.taskColor];
    }
    
    return self;
}

@end
