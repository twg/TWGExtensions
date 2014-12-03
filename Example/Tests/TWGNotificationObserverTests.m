//
//  TWGNotificationObserverTests.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/2/14.
//  Copyright 2014 John Grant. All rights reserved.
//

#import "TWGNotificationObserver.h"

@interface TWGNotificationObserver (TESTS)

- (void)triggerFireBlockWithNotification:(NSNotification *)notification;

- (void)deregisterObservers;

@end

@interface TWGNotificationObserverTests : XCTestCase

@property (nonatomic, strong) TWGNotificationObserver *notificationObserver;

@end

@implementation TWGNotificationObserverTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    self.notificationObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super tearDown];
}

- (void)testinitWithNotificationNameSetsNotificationCenterAsDefaultCenterIfNotificationParamIsNil
{
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:OCMOCK_ANY
                                                                                fireBlock:nil];
    expect(self.notificationObserver.notificationCenter).to.equal([NSNotificationCenter defaultCenter]);
    
}

- (void)testinitWithNotificationNameSetsNotificationNamesArray
{
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:@"someNoti"
                                                                                fireBlock:nil];
    expect(self.notificationObserver.notificationNames).to.equal(@[@"someNoti"]);
}

- (void)testinitWithNotificationNamesSetsNotificationNamesArray
{
    NSArray *someArray = @[@"one",@"two"];
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationNames:someArray
                                                                                 fireBlock:nil];
    expect(self.notificationObserver.notificationNames).to.equal(someArray);
}

- (void)testinitWithNotificationNameSetsFireBlock
{
    void(^someBlock)() = ^void(){};
    
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:OCMOCK_ANY
                                                                                fireBlock:someBlock];
    expect(self.notificationObserver.fireBlock).to.equal(someBlock);
}

- (void)testInitWithNotificationNamesRegistersObserversAndObserverCallsTriggerFireBlockWithNotification
{
    NSString *notificationName = @"notiName";
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:notificationName
                                                                                fireBlock:nil];
    id mockNotificationObserver = OCMPartialMock(self.notificationObserver);
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:self
                                                      userInfo:OCMOCK_ANY];
    OCMVerify([mockNotificationObserver triggerFireBlockWithNotification:OCMOCK_ANY]);
}

- (void)testPostingNotificationCallsOriginalFireBlock
{
    __block BOOL blockCalled = NO;
    void(^someBlock)() = ^void(){
        blockCalled = YES;
    };
    
    NSString *notificationName = @"notiName";
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:notificationName
                                                                                fireBlock:someBlock];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:self
                                                      userInfo:OCMOCK_ANY];
    expect(blockCalled).will.beTruthy();
}

- (void)testDeallocDeregistersObservers
{
    __block BOOL blockCalled = NO;
    void(^someBlock)() = ^void(){
        blockCalled = YES;
    };
    
    NSString *notificationName = @"notiName";
    self.notificationObserver = [[TWGNotificationObserver alloc] initWithNotificationName:notificationName
                                                                                fireBlock:someBlock];
    [self.notificationObserver deregisterObservers];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                        object:self
                                                      userInfo:OCMOCK_ANY];
    expect(blockCalled).will.beFalsy();
}

@end