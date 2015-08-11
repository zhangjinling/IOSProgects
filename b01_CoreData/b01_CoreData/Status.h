//
//  Status.h
//  b01_CoreData
//
//  Created by Seven on 15/8/11.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Status : NSManagedObject
/** 正文 */
@property (nonatomic, retain) NSString * text;
/** 日期 */
@property (nonatomic, retain) NSDate * createDate;
/** 作者 */
@property (nonatomic, retain) NSString * author;

@end
