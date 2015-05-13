//
//  Card.m
//  KVC
//
//  Created by Seven on 15/5/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Card.h"

@implementation Card
- (NSString *)description
{
    return [NSString stringWithFormat:@"<Card : %p : no = $no%@>",self,self.no];
}
@end
