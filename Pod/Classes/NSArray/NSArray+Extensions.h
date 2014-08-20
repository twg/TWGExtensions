#import <Foundation/Foundation.h>

@interface NSArray (Extensions)

- (id)objectAtIndexSafe:(NSUInteger)index;
- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger index))block;

@end
