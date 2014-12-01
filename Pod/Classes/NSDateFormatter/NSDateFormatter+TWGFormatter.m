//
//  NSDateFormatter+TWGFormatter.m
//  The Working Group
//
//  Created by Brian Gilham on 2014-12-01.
//  Copyright (c) 2014 The Working Group. All rights reserved.
//

#import "NSDateFormatter+Shared.h"

@implementation NSDateFormatter (Shared)

+ (NSDateFormatter *)ISO8601
{
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    });
    
    return sharedFormatter;
}

+ (NSDateFormatter *)UTC
{
    static NSDateFormatter *sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFormatter = [[NSDateFormatter alloc] init];
        [sharedFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    
    return sharedFormatter;
}

@end
