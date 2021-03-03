//
//  INSStatisticsTodayModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class INSPieChartDataModel;

@interface INSStatisticsTodayModel : NSObject

@property (nonatomic, strong) NSNumber *tomatoTimes;
@property (nonatomic, strong) NSNumber *tomatoMinutes;
@property (nonatomic, strong) NSNumber *tomatoQuality;
@property (nonatomic, strong) NSArray<INSPieChartDataModel *>  *pieChartDataModelArray;

@end

NS_ASSUME_NONNULL_END
