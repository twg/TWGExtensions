//
//  NSNumberFormatter+TWGFormatter.m
//  The Working Group
//
//  Created by Brian Gilham on 2014-12-01.
//  Copyright (c) 2014 The Working Group. All rights reserved.
//

#import "NSNumberFormatter+CLSShared.h"

@implementation NSNumberFormatter (CLSShared)

+ (instancetype)currencyFormatter
{
    static NSNumberFormatter *currencyFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        currencyFormatter.maximumFractionDigits = 2;
    });

    return currencyFormatter;
}
@end
