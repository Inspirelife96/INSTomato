//
//  INSStatisticsTodayViewModel.h
//  INSTomato
//
//  Created by XueFeng Chen on 2021/2/6.
//

#import <Foundation/Foundation.h>

@class INSStatisticsTodayModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSStatisticsTodayViewModel : NSObject

@property (nonatomic, copy) NSString *tomatoTimes;
@property (nonatomic, copy) NSString *tomatoMinutes;
@property (nonatomic, copy) NSString *tomatoQuality;

@property (nonatomic, copy) NSString *tomatoTimesTitle;
@property (nonatomic, copy) NSString *tomatoMinutesTitle;
@property (nonatomic, copy) NSString *tomatoQualityTitle;

@property (nonatomic, strong) UIImage *tomatoTimesImage;
@property (nonatomic, strong) UIImage *tomatoMinutesImage;
@property (nonatomic, strong) UIImage *tomatoQualityImage;

@property (nonatomic, strong) INSStatisticsTodayModel *statisticsTodayModel;

- (instancetype)initWithStatisticsTodayModel:(INSStatisticsTodayModel *)statisticsTodayModel;

@end

NS_ASSUME_NONNULL_END
