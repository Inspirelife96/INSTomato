//
//  INSPieChartDataModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSPieChartDataModel : NSObject

@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *taskColor;
@property (nonatomic, strong) NSNumber *tomatoMinutes;

@end

NS_ASSUME_NONNULL_END
