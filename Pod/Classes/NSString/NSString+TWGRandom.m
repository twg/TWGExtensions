
#import "NSString+TWGRandom.h"

@implementation NSString (TWGRandom)
static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+ (NSString *)twg_randomStringOfLength:(NSInteger)length
{
    length = length == 0 ? 5 : length;
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}
@end
