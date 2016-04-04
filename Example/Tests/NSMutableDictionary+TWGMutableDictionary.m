#import <XCTest/XCTest.h>
@import TWGExtensions;
@import Foundation;

@interface NSMutableDictionary_TWGMutableDictionary : XCTestCase

@end

@implementation NSMutableDictionary_TWGMutableDictionary

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItReturnsCorrectDictionaryWhenThereAreNonNilParams
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary safeAddObject:nil forKey:@"key1"];
    [dictionary safeAddObject:@"foo" forKey:@"key2"];
    
    XCTAssertEqual([[dictionary allKeys] count], 1);
    XCTAssertNil(dictionary[@"key1"]);
    XCTAssertTrue([dictionary[@"key2"] isEqualToString:@"foo"]);
}

- (void)testThatItReturnsCorrectDictionaryWithAllNonNilParams
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary safeAddObject:@"foo" forKey:@"key1"];
    [dictionary safeAddObject:@"bar" forKey:@"key2"];
    
    XCTAssertEqual([[dictionary allKeys] count], 2);
    XCTAssertTrue([dictionary[@"key1"] isEqualToString:@"foo"]);
    XCTAssertTrue([dictionary[@"key2"] isEqualToString:@"bar"]);
}

- (void)testThatItReturnsNilWhenAllParamsNil
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary safeAddObject:nil forKey:@"key1"];
    [dictionary safeAddObject:nil forKey:@"key2"];
    
    XCTAssertEqual([[dictionary allKeys] count], 0);
    XCTAssertNil(dictionary[@"key1"]);
    XCTAssertNil(dictionary[@"key2"]);
    
}

@end

