@import Foundation;

@interface NSObject (TWGProperty)

+ (NSSet *)determineCompileTimePropertyNames;
- (void)mergeWithObject:(NSObject *)otherObject;

@end
