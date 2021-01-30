//
//  INSTomatoModel.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTomatoModel : NSObject

@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, strong) NSNumber *breakTimes;
@property (nonatomic, strong) NSNumber *tomatoMinutes;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initTaskId:(NSString *)taskId
                 startDate:(NSDate *)startDate
                   endDate:(NSDate *)endDate
                breakTimes:(NSNumber *)breakTimes
             tomatoMinutes:(NSNumber *)tomatoMinutes NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithTomatoDictionary:(NSDictionary *)tomatoDictionary NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)convertToDictionary;

@end

NS_ASSUME_NONNULL_END
