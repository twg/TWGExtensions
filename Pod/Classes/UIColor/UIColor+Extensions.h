#import <UIKit/UIKit.h>

@interface UIColor (Extensions)
+ (UIColor *)colorFromHexString:(NSString *)hexString
                       andAlpha:(float)alpha;

- (UIColor *)colorWithChangedAlpha:(float)alpha;
@end
