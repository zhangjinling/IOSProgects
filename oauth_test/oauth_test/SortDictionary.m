//
//  SortDictionary.m
//  oauth_test
//
//  Created by Seven on 15/8/19.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "SortDictionary.h"

@implementation SortDictionary
+ (NSString *)sortDictionary:(NSDictionary *)dict
{
    NSMutableArray *keyArr = [NSMutableArray array];
    for (NSString *str in dict) {
        [keyArr insertObject:str atIndex:0];
    }

    NSArray *sortedArray = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    NSLog(@"%@",sortedArray);
    NSMutableDictionary *prarma = [NSMutableDictionary dictionary];
    NSString *queryString = [NSString string];
    for (NSString *str in sortedArray) {
        [prarma setValue:dict[str] forKey:str];
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",str,dict[str]]];

    }

    return queryString;
}
@end
