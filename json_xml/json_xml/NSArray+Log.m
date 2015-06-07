//
//  NSArray+Log.m
//  json_xml
//
//  Created by Seven on 15/6/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"%lu (" , (unsigned long)self.count];
    
    for (NSObject *obj in self) {
        [str appendFormat:@"\t%@\n,",obj];
    }
    
    [str appendFormat:@")"];
    
    return str;
    
}
@end
