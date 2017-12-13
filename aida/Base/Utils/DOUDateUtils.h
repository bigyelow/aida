//
//  DOUDateUtils.h
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface DOUDateUtils : NSObject

/**
 *  @return 今年，返回格式是 MM-dd，否则 yyyy-MM-dd
 */
+ (NSString *)stringOfDate:(NSDate*)theDate;

+ (NSString *)stringOfDateTime:(NSDate*)theDate;

+ (NSString *)timeDisplayStringWithBeginTime:(NSDate *)beignTime endTime:(NSDate *)endTime;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)fmt;
+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)fmt;

/**
 @return 今天、昨天、`stringOfDate`
 */
+ (NSString *)relativeDateStringFromDate:(NSDate *)date;

/**
 *  @param day  天数
 *
 *  @return 当前时间减去date的天数值与day比较。如果差值为0,1;返回今天、昨天；
 *          差值小于day，返回今天、昨天、day-1天前；
 *          差值大于day，返回stringOfDate:今年，返回格式是 MM-dd，否则 yyyy-MM-dd
 */
+ (NSString *)relativeDateStringFromDate:(NSDate *)date days:(NSInteger)day;

+ (NSString *)relativeDateStringFromDate:(NSDate *)date days:(NSInteger)day format:(NSString *)fmt;

+ (NSString *)relativeIntervalFromDate:(NSDate *)date;

+ (NSString *)relativeIntervalFromDate:(NSDate *)date significantUnits:(NSCalendarUnit)units;

/**
 *  把时间转换为日期。如果 `excludeCurrentYear` 为 YES，并且 `date` 是今年，日期格式为 MM-dd，否则 yyyy-MM-dd，
 */
+ (NSString *)dayStringFromDate:(NSDate *)date excludeCurrentYear:(BOOL)excludeCurrentYear useChinese:(BOOL)useChinese;

/**
 *  日期转换为时间对象。日期格式为 yyyy-MM-dd。如果只是 MM-dd，则表示今年。
 */
+ (NSDate *)dateFromDayString:(NSString *)dayString;

/**
 获取北京时间日历
 */
+ (NSCalendar *)beijingCalendar;

@end

NS_ASSUME_NONNULL_END
