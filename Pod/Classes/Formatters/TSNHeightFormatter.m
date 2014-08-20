//
//  TSNHeightFormatter.m
//  TSNGolf
//
//  Created by John Grant on 2014-03-19.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "TSNHeightFormatter.h"

const NSInteger NUMBER_OF_INCHES_IN_FEET = 12;

const unichar DOUBLE_PRIME = 0x2033;
const unichar SINGLE_PRIME = 0x2032;

@implementation TSNHeightFormatter

- (NSString *)stringFromNumber:(NSNumber *)number
{
    if (!number) {
        return nil;
    }
    
    NSInteger numberOfFeet = (NSInteger)[number integerValue] / NUMBER_OF_INCHES_IN_FEET;
    NSInteger numberOfInches = (NSInteger)[number integerValue] % NUMBER_OF_INCHES_IN_FEET;
    return [NSString stringWithFormat:@"%d%C%d%C", numberOfFeet, SINGLE_PRIME, numberOfInches, DOUBLE_PRIME];
}

@end
