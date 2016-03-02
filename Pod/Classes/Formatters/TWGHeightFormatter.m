
#import "TWGHeightFormatter.h"

const NSInteger NUMBER_OF_INCHES_IN_FEET = 12;

const unichar DOUBLE_PRIME = 0x2033;
const unichar SINGLE_PRIME = 0x2032;

@implementation TWGHeightFormatter

- (NSString *)stringFromNumber:(NSNumber *)number
{
    if (!number) {
        return nil;
    }

    NSInteger numberOfFeet = (NSInteger)[number integerValue] / NUMBER_OF_INCHES_IN_FEET;
    NSInteger numberOfInches = (NSInteger)[number integerValue] % NUMBER_OF_INCHES_IN_FEET;
    return [NSString
        stringWithFormat:@"%ld%C%ldd%C", (long)numberOfFeet, SINGLE_PRIME, (long)numberOfInches, DOUBLE_PRIME];
}

@end
