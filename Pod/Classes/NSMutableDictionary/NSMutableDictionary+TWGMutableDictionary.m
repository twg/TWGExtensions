#import "NSMutableDictionary+TWGMutableDictionary.h"

@implementation NSMutableDictionary (TWGMutableDictionary)

- (void)safeAddObject:(id)object forKey:(id<NSCopying>)key
{
    if (object) {
        [self setObject:object forKey:key];
    }
}

@end
