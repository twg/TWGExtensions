//
//  TWGKeyboardObserverTests.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/2/14.
//  Copyright 2014 John Grant. All rights reserved.
//

#import "TWGKeyboardObserver.h"

@interface TWGKeyboardObserver (TEST)
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
@end

@interface TWGKeyboardObserverTests : XCTestCase
@property (nonatomic, strong) TWGKeyboardObserver *observer;
@property (nonatomic, strong) id notificationCenterMock;
@property (nonatomic, strong) id mockDelegate;
@end

@implementation TWGKeyboardObserverTests

- (void)setUp
{
    [super setUp];
    self.mockDelegate = [OCMockObject niceMockForProtocol:@protocol(TWGKeyboardObserverDelegate)];
    self.notificationCenterMock = [OCMockObject niceMockForClass:[NSNotificationCenter class]];
    self.observer = [[TWGKeyboardObserver alloc] initWithNotificationCenter:self.notificationCenterMock];
    self.observer.delegate = self.mockDelegate;
}

- (void)tearDown
{
    self.observer = nil;
    [super tearDown];
}

- (void)testInitSubscribesToKeyboardShowNotifications
{
    [[self.notificationCenterMock expect] addObserver:OCMOCK_ANY
                                             selector:@selector(willShowKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.observer = [[TWGKeyboardObserver alloc] initWithNotificationCenter:self.notificationCenterMock];
    
    [self.notificationCenterMock verify];
}

- (void)testInitSubscribesToKeyboardHideNotifications
{
    [[self.notificationCenterMock expect] addObserver:OCMOCK_ANY
                                             selector:@selector(willHideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.observer = [[TWGKeyboardObserver alloc] initWithNotificationCenter:self.notificationCenterMock];
    
    [self.notificationCenterMock verify];
}

- (void)testWillShowKeyboardNotifiesDelegate
{
    CGRect frame = CGRectZero;
    CGFloat duration = 1;
    
    [[self.mockDelegate expect] keyboardObserver:self.observer willShowKeyboardWithFrame:frame duration:duration];
    
    NSDictionary *userInfo = @{UIKeyboardFrameBeginUserInfoKey: [NSValue valueWithCGRect:frame],
                               UIKeyboardAnimationDurationUserInfoKey: @(duration)
                               };
    NSNotification *notification = [[NSNotification alloc] initWithName:UIKeyboardWillShowNotification
                                                                 object:nil
                                                               userInfo:userInfo];
    [self.observer willShowKeyboard:notification];
    
    [self.mockDelegate verify];
}

- (void)testWillHideKeyboardNotifiesDelegate
{
    CGRect frame = CGRectZero;
    CGFloat duration = 1;
    
    [[self.mockDelegate expect] keyboardObserver:self.observer willHideKeyboardFromFrame:frame duration:duration];
    
    NSDictionary *userInfo = @{UIKeyboardFrameBeginUserInfoKey: [NSValue valueWithCGRect:frame],
                               UIKeyboardAnimationDurationUserInfoKey: @(duration)
                               };
    NSNotification *notification = [[NSNotification alloc] initWithName:UIKeyboardWillShowNotification
                                                                 object:nil
                                                               userInfo:userInfo];
    
    
    [self.observer willHideKeyboard:notification];
    
    [self.mockDelegate verify];
}


@end