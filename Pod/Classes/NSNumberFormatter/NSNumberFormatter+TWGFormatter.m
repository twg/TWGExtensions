
#import "NSNumberFormatter+TWGFormatter.h"

@implementation NSNumberFormatter (TWGFormatter)

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
