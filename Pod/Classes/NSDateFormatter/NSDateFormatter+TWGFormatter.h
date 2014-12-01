//
//  NSDateFormatter+TWGFormatter.h
//  The Working Group
//
//  Created by Brian Gilham on 2014-12-01.
//  Copyright (c) 2014 The Working Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (TWGFormatter)

+ (NSDateFormatter *)ISO8601;

+ (NSDateFormatter *)UTC;

@end
