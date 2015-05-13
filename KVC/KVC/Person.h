//
//  Person.h
//  KVC
//
//  Created by Seven on 15/5/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Card;
@interface Person : NSObject

@property(strong,nonatomic) NSString *name;
@property(assign,nonatomic) NSInteger age;
@property(strong,nonatomic) Card *card;

@property(strong,nonatomic) NSArray *books;

@end
