//
//  NSDate+CPFDateExt.m
//  百思不得姐
//
//  Created by cuipengfei on 16/7/11.
//  Copyright © 2016年 崔鹏飞. All rights reserved.
//

#import "NSDate+CPFDateExt.h"

@implementation NSDate (CPFDateExt)

- (NSDateComponents *) intervalFromDate:(NSDate *)from{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit calenderUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:calenderUnit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger currentYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger thisYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return currentYear == thisYear;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *currentDateString = [fmt stringFromDate:[NSDate date]];
    NSString *thisDateString = [fmt stringFromDate:self];
    
    return [currentDateString isEqualToString:thisDateString];
}

- (BOOL)isYesterday
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *currentDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *thisDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:thisDate toDate:currentDate options:0];
    
    return cmps.year == 0
            && cmps.month == 0
            && cmps.day == 1;
}
@end
