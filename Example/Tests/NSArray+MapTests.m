//
//  NSArray+MapTests.m
//  TWGExtensions
//
//  Created by Alex on 2016-04-25.
//  Copyright © 2016 John Grant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
@import TWGExtensions;

@interface NSArray_MapTests : XCTestCase

@property (strong, nonatomic) NSArray *mapArray;

@end

@implementation NSArray_MapTests

- (void)setUp {
    [super setUp];

}

- (void)tearDown {

    [super tearDown];
}

- (void)testExample {
    [self.mapArray twg]

}

@end
