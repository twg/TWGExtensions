//
//  NSArray+Map.m
//  Pods
//
//  Created by Alex on 2016-04-25.
//
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (NSArray *)twg_mapWithBlock:(id (^)(id))block
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        [array addObject:block(object)];
    }
    return array;
}

@end
