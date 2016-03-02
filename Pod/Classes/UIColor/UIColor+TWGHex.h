
@import UIKit;

@interface UIColor (TWGHex)

+ (UIColor *)twg_colorFromHexString:(NSString *)hexString andAlpha:(float)alpha;
- (UIColor *)twg_colorWithChangedAlpha:(float)alpha;

@end
