//
//  Book.h
//  KVC
//
//  Created by Seven on 15/5/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Book : NSObject
@property(strong,nonatomic) NSString *bookName;
@property(assign,nonatomic) CGFloat price;
@end
