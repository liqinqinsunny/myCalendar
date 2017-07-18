//
//  DBCommon.m
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import "DBCommon.h"

@implementation DBCommon


// 这个月份一共有多少天数
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date withDatestr:(NSString *)datestr
{
    if (datestr != nil) {
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        format.dateFormat = @"yyyy-MM-dd";
        date = [format dateFromString:datestr];
    }
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
}


// 这个月份第一天是周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr
{
    if (datestr != nil) {
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        format.dateFormat = @"yyyy-MM-dd";
        date = [format dateFromString:datestr];
    }
  
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1]; // 设置为周一
    
    // 找到第一天
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    
    NSDate *firstdayDate = [calendar dateFromComponents:comp];
    
    NSUInteger days = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstdayDate];
    
    return days - 1;
}

@end
