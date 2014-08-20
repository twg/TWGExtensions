#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

// Assumes input like "#00FF00" (#RRGGBB)
+ (UIColor *)colorFromHexString:(NSString *)hexString
                       andAlpha:(float)alpha
{
    if (!hexString){
        return nil;
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:alpha];
}

- (UIColor *)colorWithChangedAlpha:(float)alpha;
{
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
