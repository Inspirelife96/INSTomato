//
//  INSPieChartDataViewModel.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import <Foundation/Foundation.h>

@class INSPieChartDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSPieChartDataViewModel : NSObject

@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, assign) double tomatoMinutes;
@property (nonatomic, copy) UIColor *taskColor;

- (instancetype)initWithPieChartDataModel:(INSPieChartDataModel *)pieChartDataModel;

@end

NS_ASSUME_NONNULL_END
