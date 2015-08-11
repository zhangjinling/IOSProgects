//
//  Department.h
//  b01_CoreData
//
//  Created by Seven on 15/8/11.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Department : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * createData;
@property (nonatomic, retain) NSString * departNo;

@end
