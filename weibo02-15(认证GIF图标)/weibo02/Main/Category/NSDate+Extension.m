//
//  NSDate+Extension.m
//  weibo02
//
//  Created by Seven on 15/7/16.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  判断是否是今年
 *
 *  @param date 创建的如期
 *
 *  @return 返回bool值
 */
- (BOOL) isThisYear
{
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit 代表想获得那些差值
    NSCalendarUnit unit = NSCalendarUnitYear;
    //获得某个时间的年与日时分秒
    NSDateComponents *createDateCmp = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmp = [calendar components:unit fromDate:[NSDate date]];
    return createDateCmp.year == nowCmp.year;
}
/**
 *  判断某个时间是否为昨天
 *
 *  @param date 日期
 *
 *  @return bool值
 */
- (BOOL) isYesterday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //去除尾数后的时间字符串
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    //取出尾数后的时间 2012-10-10 00:00:00
    NSDate *date = [[NSDate alloc]init];
    date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
/**
 *  判断是否问今天
 *
 *  @param date 日期
 *
 *  @return bool  返回值
 */
- (BOOL) isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //去除尾数后的时间字符串
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
    
}

@end
