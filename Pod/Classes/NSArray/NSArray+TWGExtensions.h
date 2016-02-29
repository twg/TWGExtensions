
@import Foundation;

@interface NSArray (TWGExtensions)

- (id)twg_objectAtIndexSafe:(NSUInteger)index;
- (NSArray *)twg_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger index))block;

@end
