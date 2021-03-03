//
//  INSStatisticsTodayDataView.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import <UIKit/UIKit.h>

@class INSStatisticsTodayDataViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSStatisticsTodayDataView : UIView

- (void)configWithDataValue:(NSString *)value title:(NSString *)title image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
