
#import "NSArray+TWGGroup.h"

@implementation NSArray (TWGGroup)

- (NSArray *)twg_sortWithDescriptor:(NSSortDescriptor *)sortDescriptor andGroupBy:(NSString *(^)(id))block
{
    NSParameterAssert(sortDescriptor);
    NSParameterAssert(block);
    
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSMutableArray *groups = [NSMutableArray array];
    id currentGroup;
    
    NSMutableArray *nilGroup = [NSMutableArray array];
    NSMutableArray *group;
    for (id object in sortedArray) {
        NSString *objectGroup = block(object);
        
        if (!objectGroup) {
            [nilGroup addObject:object];
        }else if ([objectGroup isEqualToString:currentGroup]) {
            [group addObject:object];
        }else{
            group = [NSMutableArray arrayWithObject:object];
            [groups addObject:group];
            currentGroup = objectGroup;
        }
    }
    
    if ([nilGroup count] > 0) {
        [groups addObject:nilGroup];
    }
    
    return [NSArray arrayWithArray:groups];
}

@end
