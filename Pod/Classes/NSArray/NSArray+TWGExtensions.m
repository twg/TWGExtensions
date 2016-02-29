
#import "NSArray+TWGExtensions.h"

@implementation NSArray (TWGExtensions)

- (id)twg_objectAtIndexSafe:(NSUInteger)index
{
    return (index >= self.count) ? nil : self[index];
}

- (NSArray *)twg_mapObjectsUsingBlock:(id (^)(id obj, NSUInteger index))block
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}

@end
