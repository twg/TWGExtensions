//
//  NSArray+GolfExtensions.h
//  TSNGolf
//
//  Created by John Grant on 2/14/2014.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GolfExtensions)

- (NSArray *)sortWithDescriptor:(NSSortDescriptor *)sortDescriptor andGroupBy:(NSString *(^)(id object))block;

@end
