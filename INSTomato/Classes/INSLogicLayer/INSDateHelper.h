//
//  INSDateHelper.h
//  ChameleonFramework
//
//  Created by XueFeng Chen on 2021/1/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSDateHelper : NSObject

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;

+ (NSString *)stringOfDay:(NSDate *)date;
+ (NSString *)stringOfHour:(NSDate *)date;
+ (NSString *)stringOfWeekday:(NSDate *)date;
+ (NSString *)stringOfDayWithWeekDay:(NSDate *)date;

+ (NSString *)minutesFormatBySeconds:(CGFloat)seconds;

+ (NSArray *)weekDaysArray;
+ (NSArray *)monthArray;
+ (NSArray *)hourArray;

+ (NSString *)weekDayName:(NSInteger)index;

+ (NSArray *)tomatoMinuteArray;
+ (NSArray *)tomatoMinuteTypeArray;

+ (NSArray *)restMinuteArray;
+ (NSArray *)restMinuteTypeArray;

+ (NSArray *)alertHourArray;
+ (NSArray *)alertMinuteArray;

+ (NSString *)dateToString:(NSDate *)date withForamt:(NSString *)format;
+ (NSDate *)stringToDate:(NSString *)dateString withForamt:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
