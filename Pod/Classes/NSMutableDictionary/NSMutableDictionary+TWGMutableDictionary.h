@import Foundation;

@interface NSMutableDictionary (TWGMutableDictionary)

- (void)safeAddObject:(id)object forKey:(id<NSCopying>)key;

@end
