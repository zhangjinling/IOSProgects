//
//  Book.m
//  KVC
//
//  Created by Seven on 15/5/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Book.h"

@implementation Book

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Book : %p : bookname = %@ bookprice ＝ %f>",self,self.bookName,self.price];

}
@end
