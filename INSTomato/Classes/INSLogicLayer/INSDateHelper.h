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

+ (NSArray *)weekDaysList;
+ (NSArray *)monthList;
+ (NSArray *)hourList;

+ (NSString *)weekDayName:(NSInteger)index;

+ (NSArray *)tomatoMinuteList;
+ (NSArray *)tomatoMinuteType;

+ (NSArray *)restMinuteList;
+ (NSArray *)restMinuteType;

+ (NSArray *)alertHourList;
+ (NSArray *)alertMinuteList;

+ (NSString *)dateToString:(NSDate *)date withForamt:(NSString *)format;
+ (NSDate *)stringToDate:(NSString *)dateString withForamt:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
