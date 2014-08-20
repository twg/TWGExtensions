//
//  NSArray+GolfExtensions.m
//  TSNGolf
//
//  Created by John Grant on 2/14/2014.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "NSArray+GolfExtensions.h"

@implementation NSArray (GolfExtensions)

- (NSArray *)sortWithDescriptor:(NSSortDescriptor *)sortDescriptor andGroupBy:(NSString *(^)(id))block
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
