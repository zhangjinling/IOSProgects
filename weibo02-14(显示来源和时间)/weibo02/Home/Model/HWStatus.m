//
//  HWStatus.m
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  微博

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhoto.h"

@implementation HWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[HWPhoto class]};
}
/**
 *  重写微博来源的set方法
 *
 *  @param source 微博来源
 */
- (void)setSource:(NSString *)source
{
    //截取来源
    //1.正则表达式
    //2.截取
//    NSRange range;
//    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</" options:NSBackwardsSearch].location - range.location;
//    
//    _source = [NSString stringWithFormat:@"来自:%@",[source substringWithRange:range]];
}




/**
 1.今年：
    今天：
        //一分钟内：刚刚
        //xx分钟前：1-59分钟内
        //xx小时前：大于60分钟
    昨天：
        昨天  xx点xx分
    其他：
        月份+日期
 2.非今年
    年+月+日
 //Wed Jul 15 21:24:12 +0800 2015
 **/
- (NSString *)created_at
{
    //字符串转换成日期类型
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //转化这个欧美时间需要设置locate
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    //设置日期的格式，（声明字符串里面每个数字单词的含义）
    //E:星期几   M:月份   H: 24小时制   m:分钟   s: 秒   y：年    d：几号日期（这个月第几天）
    fmt.dateFormat = @"EEE MM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [fmt dateFromString:_created_at];
//    fmt.dateFormat = @"yyyy - MM - dd  HH:mm:ss";
//    HWLog(@"%@",createDate);
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSCalendarUnit 代表想获得那些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    //比较两个时间的差值
    NSDateComponents *cmp = [calendar components:unit fromDate:createDate toDate:now options:0];
//    
//    //获得某个时间的年月日 时分秒
//    NSDateComponents *createDateCmp = [calendar components:unit fromDate:createDate];
//    
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if ([createDate isToday]){
            if(cmp.hour >= 1){
                return [NSString stringWithFormat:@"%ld小时前",(long)cmp.hour];
            }else if (cmp.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmp.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}
///**
// *  判断是否是今年
// *
// *  @param date 创建的如期
// *
// *  @return 返回bool值
// */
//- (BOOL) isThisYear:(NSDate *)date
//{
//    //日历对象
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    //NSCalendarUnit 代表想获得那些差值
//    NSCalendarUnit unit = NSCalendarUnitYear;
//    //获得某个时间的年与日时分秒
//    NSDateComponents *createDateCmp = [calendar components:unit fromDate:date];
//    NSDateComponents *nowCmp = [calendar components:unit fromDate:[NSDate date]];
//    return createDateCmp.year == nowCmp.year;
//}
///**
// *  判断某个时间是否为昨天
// *
// *  @param date 日期
// *
// *  @return bool值
// */
//- (BOOL) isYesterday:(NSDate *)date
//{
//    NSDate *now = [NSDate date];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    //去除尾数后的时间字符串
//    fmt.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = [fmt stringFromDate:date];
//    NSString *nowStr = [fmt stringFromDate:now];
//    
//    //取出尾数后的时间 2012-10-10 00:00:00
//    date = [fmt dateFromString:dateStr];
//    now = [fmt dateFromString:nowStr];
//    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//
//    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
//    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
//}
///**
// *  判断是否问今天
// *
// *  @param date 日期
// *
// *  @return bool  返回值
// */
//- (BOOL) isToday:(NSDate *)date
//{
//    NSDate *now = [NSDate date];
//    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
//    //去除尾数后的时间字符串
//    fmt.dateFormat = @"yyyy-MM-dd";
//    NSString *dateStr = [fmt stringFromDate:date];
//    NSString *nowStr = [fmt stringFromDate:now];
//    return [dateStr isEqualToString:nowStr];
//
//}
@end
