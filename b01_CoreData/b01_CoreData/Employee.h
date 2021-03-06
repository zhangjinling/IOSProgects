//
//  Employee.h
//  b01_CoreData
//
//  Created by Seven on 15/8/11.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Department *depart;

@end
