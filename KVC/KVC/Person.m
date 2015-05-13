//
//  Person.m
//  KVC
//
//  Created by Seven on 15/5/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Person.h"

@implementation Person
- (NSString *)description
{
    return [NSString stringWithFormat:@"<Person: %p name = %@ age = %ld card = %@  books = %@>",self,self.name,self.age,self.card,self.books];
}
@end
