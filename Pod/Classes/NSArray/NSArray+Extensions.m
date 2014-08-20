#import "NSArray+Extensions.h"

@implementation NSArray (Extensions)

- (id)objectAtIndexSafe:(NSUInteger)index
{
    return (index >= self.count) ? nil : self[index];
}

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger index))block{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}

@end
