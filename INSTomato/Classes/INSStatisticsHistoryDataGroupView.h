//
//  INSStatisticsHistoryDataGroupView.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/7.
//

#import <UIKit/UIKit.h>

@class INSStatisticsHistoryViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSStatisticsHistoryDataGroupView : UIView

- (void)configWithStatisticsHistoryViewModel:(INSStatisticsHistoryViewModel *)statisticsHistoryVM;

@end

NS_ASSUME_NONNULL_END
