//
//  DBCommon.h
//  myCalendar
//
//  Created by lqq on 17/4/12.
//  Copyright © 2017年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBCommon : NSObject

// 这个月份一共有多少天数
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date withDatestr:(NSString *)datestr;

// 这个月份第一天是周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date with:(NSString*)datestr ;


@end
