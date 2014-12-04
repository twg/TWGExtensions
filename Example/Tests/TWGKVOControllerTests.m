#import "TWGKVOController.h"

@interface TWGTestKVOObject : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *text;
@end

@implementation TWGTestKVOObject

@end

@interface TWGKVOControllerTests : XCTestCase
@property (nonatomic, strong) TWGKVOController *kvoController;
@property (nonatomic, strong) TWGTestKVOObject *object;
@end

@implementation TWGKVOControllerTests

- (void)setUp
{
    [super setUp];
    self.object = [[TWGTestKVOObject alloc] init];
    self.kvoController = [[TWGKVOController alloc] init];
}

- (void)tearDown
{
    self.kvoController = nil;
    [super tearDown];
}

- (void)testInitWithObserverReturnsAnController
{
    expect(self.kvoController).toNot.beNil();
}

- (void)testBlockCalledWhenChangeOccurs
{
    __block BOOL blockCalled = NO;
    [self.kvoController observe:self.object keyPaths:@[@"title"] block:^(id object, NSDictionary *change) {
        blockCalled = YES;
    }];
    
    self.object.title = @"new title";
    expect(blockCalled).to.beTruthy();
}

- (void)testControllerCanObserveMultipleKeyPaths
{
    __block BOOL blockCalled = NO;
    [self.kvoController observe:self.object keyPaths:@[@"title", @"detail"] block:^(id object, NSDictionary *change) {
        blockCalled = YES;
    }];
    self.object.title = @"new";
    expect(blockCalled).to.beTruthy();
    
    blockCalled = NO;
    
    self.object.detail = @"123";
    expect(blockCalled).to.beTruthy();
}

- (void)testChangingOtherPropertyDoesntCallBlock
{
    __block BOOL blockCalled = NO;
    [self.kvoController observe:self.object keyPaths:@[@"title", @"detail"] block:^(id object, NSDictionary *change) {
        blockCalled = YES;
    }];
    self.object.text = @"new";
    expect(blockCalled).to.beFalsy();
}

- (void)testCallingObserveASecondTimeDoesNothing
{
    __block NSInteger blockCalled = 0;
    [self.kvoController observe:self.object keyPaths:@[@"title", @"detail"] block:^(id object, NSDictionary *change) {
        blockCalled = 1;
    }];
    
    [self.kvoController observe:self.object keyPaths:@[@"title", @"text"] block:^(id object, NSDictionary *change) {
        blockCalled = 2;
    }];
    
    self.object.title = @"new";
    expect(blockCalled).to.equal(1);
    
    self.object.text = @"test";
    expect(blockCalled).to.equal(1);
}

@end