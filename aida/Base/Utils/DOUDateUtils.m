//
//  DOUDateUtils.m
//  aida
//
//  Created by bigyelow on 13/12/2017.
//  Copyright © 2017 bigyelow. All rights reserved.
//

#import <FormatterKit/TTTTimeIntervalFormatter.h>

#import "DOUDateUtils.h"
#import "AIUtilsMacros.h"

@implementation DOUDateUtils

+ (NSString *)stringOfDate:(NSDate *)theDate
{
  NSParameterAssert(theDate != nil);

  NSCalendar *calendar = [[self class] beijingCalendar];
  NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
  | NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *nowComps = [calendar components:units fromDate:[NSDate date]];
  NSDateComponents *theDateComps = [calendar components:units fromDate:theDate];
  NSString *timeStr = nil;
  if (nowComps.year == theDateComps.year) {
    if (nowComps.month == theDateComps.month) {
      if (nowComps.day == theDateComps.day) {
        timeStr = [NSString stringWithFormat:@"%02" PRI_NSInteger ":%02" PRI_NSInteger,
                   theDateComps.hour, theDateComps.minute];
      } else {
        timeStr = [NSString stringWithFormat:@"%02" PRI_NSInteger "-%02" PRI_NSInteger,
                   theDateComps.month, theDateComps.day];
      }
    } else {
      timeStr = [NSString stringWithFormat:@"%02" PRI_NSInteger "-%02" PRI_NSInteger,
                 theDateComps.month, theDateComps.day];
    }
  } else {
    timeStr = [NSString stringWithFormat:@"%" PRI_NSInteger "-%02" PRI_NSInteger "-%02" PRI_NSInteger,
               theDateComps.year, theDateComps.month, theDateComps.day];
  }

  NSAssert(timeStr != nil, @"formatted date string should not be nil");

  return timeStr ?: @"";
}

+ (NSString *)stringOfDateTime:(NSDate*)theDate
{
  NSParameterAssert(theDate != nil);

  NSCalendar *calendar = [[self class] beijingCalendar];
  NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
  | NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *nowComps = [calendar components:units fromDate:[NSDate date]];
  NSDateComponents *theDateComps = [calendar components:units fromDate:theDate];
  NSString *timeExceptYear = [NSString stringWithFormat:
                              @"%02" PRI_NSInteger "-%02" PRI_NSInteger " %02" PRI_NSInteger ":%02" PRI_NSInteger,
                              theDateComps.month, theDateComps.day, theDateComps.hour, theDateComps.minute];
  if (nowComps.year == theDateComps.year) {
    return timeExceptYear;
  } else {
    return [NSString stringWithFormat:@"%" PRI_NSInteger "-%@", theDateComps.year, timeExceptYear];
  }
}

+ (NSString *)timeDisplayStringWithBeginTime:(NSDate *)beignTime endTime:(NSDate *)endTime
{
  NSCalendar *calendar = [[self class] beijingCalendar];
  NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
  | NSCalendarUnitHour | NSCalendarUnitMinute;
  NSDateComponents *beginComps = [calendar components:units fromDate:beignTime];
  NSDateComponents *endComps = [calendar components:units fromDate:endTime];
  NSString *startDisplayStr = [[self class] stringOfDateTime:beignTime];
  if (beginComps.year == endComps.year && beginComps.month == endComps.month && beginComps.day == endComps.day) {
    return [startDisplayStr stringByAppendingFormat:@" -- %02" PRI_NSInteger ":%02" PRI_NSInteger,
            endComps.hour, endComps.minute];
  } else {
    return [startDisplayStr stringByAppendingFormat:@" -- %@", [[self class] stringOfDateTime:endTime]];
  }
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)fmt
{
  return [[[self class] dateFormatterWithFormat:fmt] stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)fmt
{
  return [[[self class] dateFormatterWithFormat:fmt] dateFromString:date];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)fmt
{
  static NSCache *cache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    cache = [[NSCache alloc] init];
  });

  NSDateFormatter *instance = [cache objectForKey:fmt];
  if (instance == nil) {
    @synchronized(cache) {
      instance = [cache objectForKey:fmt];
      if (instance == nil) {
        instance = [[NSDateFormatter alloc] init];
        instance.dateFormat = fmt;
        instance.calendar = [self beijingCalendar];
        instance.timeZone = instance.calendar.timeZone;
        [cache setObject:instance forKey:fmt];
      }
    }
  }
  return instance;
}

+ (NSString *)relativeDateStringFromDate:(NSDate *)date
{
  return [[self class] relativeDateStringFromDate:date days:0];
}

+ (NSString *)relativeDateStringFromDate:(NSDate *)date days:(NSInteger)day
{
  return [self relativeDateStringFromDate:date days:day format:@""];
}

+ (NSString *)relativeDateStringFromDate:(NSDate *)date days:(NSInteger)day format:(NSString *)fmt
{
  if (!date) {
    return @"";
  }
  NSCalendar *calendar = [self beijingCalendar];
  NSDate *fromDate;
  NSDate *toDate;

  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
               interval:NULL forDate:date];
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
               interval:NULL forDate:[NSDate date]];
  NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];

  if (difference.day < day) {
    return [self relativeIntervalFromDate:date];
  }

  if ([fmt isEqualToString:@""]) {
    return [self stringOfDate:date];
  } else {
    return [self stringFromDate:date format:fmt];
  }
}

+ (NSString *)relativeIntervalFromDate:(NSDate *)date
{
  return [self relativeIntervalFromDate:date significantUnits:NSCalendarUnitYear | NSCalendarUnitMonth
          | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond];
}

+ (NSString *)relativeIntervalFromDate:(NSDate *)date significantUnits:(NSCalendarUnit)units
{
  if (!date) {
    return @"";
  }

  static TTTTimeIntervalFormatter *formatter;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    formatter = [[TTTTimeIntervalFormatter alloc] init];
    formatter.calendar = [self beijingCalendar];
  });
  formatter.significantUnits = units;

  // TTTTimeIntervalFormatter bug workaround
  NSCalendar *calendar = [self beijingCalendar];
  NSDate *fromDate;
  NSDate *toDate;

  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
               interval:NULL forDate:date];
  [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
               interval:NULL forDate:[NSDate date]];
  NSDateComponents *timeDiff = [calendar components:NSCalendarUnitDay fromDate:date toDate:[NSDate date] options:0];
  if (timeDiff.day > 0) {
    return [formatter stringForTimeIntervalFromDate:toDate toDate:fromDate];
  }

  return [formatter stringForTimeInterval:[date timeIntervalSinceNow]];
}

+ (NSString *)dayStringFromDate:(NSDate *)date excludeCurrentYear:(BOOL)excludeCurrentYear useChinese:(BOOL)useChinese
{
  NSCalendar *calendar = [[self class] beijingCalendar];
  NSDateComponents *dateComps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
  NSDateComponents *nowComps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
  if (excludeCurrentYear && dateComps.year == nowComps.year) {
    NSString *format = useChinese ? @"%@月%@日" : @"%@-%@";
    return [NSString stringWithFormat:format, @(dateComps.month), @(dateComps.day)];
  } else {
    NSString *format = useChinese ? @"%@年%@月%@日" : @"%@-%@-%@";
    return [NSString stringWithFormat:format, @(dateComps.year), @(dateComps.month), @(dateComps.day)];
  }
}

+ (NSDate *)dateFromDayString:(NSString *)dayString
{
  if ([dayString rangeOfString:@"-"].location != 4) {
    NSInteger year = [[[self class] beijingCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]].year;
    dayString = [NSString stringWithFormat:@"%" PRI_NSInteger "-%@", year, dayString];
  }
  return [self dateFromString:dayString format:@"yyyy-MM-dd"];
}

+ (NSCalendar *)beijingCalendar
{
  static NSCalendar *calendar = nil;
  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 60 * 60];
  });

  return calendar;
}

@end
