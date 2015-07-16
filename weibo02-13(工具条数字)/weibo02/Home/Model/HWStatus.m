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
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMonth |NSCalendarUnitSecond;
    //比较两个时间的差值
    NSDateComponents *cmp = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    //获得某个时间的年月日 时分秒
    NSDateComponents *createDateCmp = [calendar components:unit fromDate:createDate];
    
//    if (<#condition#>) {
//        <#statements#>
//    }
    HWLog(@"%@",cmp);
    return _created_at;
}
@end
