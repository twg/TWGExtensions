
@import Foundation;

@interface NSArray (TWGGroup)

- (NSArray *)twg_sortWithDescriptor:(NSSortDescriptor *)sortDescriptor andGroupBy:(NSString * (^)(id object))block;

@end
