//
//  Video.m
//  json_xml
//
//  Created by Seven on 15/6/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Video.h"

@implementation Video

- (NSString *)lengthStr
{
    return [NSString stringWithFormat:@"%02ld:%02ld",self.length/60,self.length%60];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<Video: %p,videoId:%d,name %@"
            " ,length:%ld ,videourl :%@,imagURl:%@,desc:%@,"
            "teacher:%@>",self,self.videoId,self.name,self.length,self.videoURL,self.imageURL,self.desc,self.teacher];
}
@end
