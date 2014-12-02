//
//  TWGGridViewControllerTests.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/2/14.
//  Copyright 2014 John Grant. All rights reserved.
//

#import "TWGGridViewController.h"
#import "TWGLoadingIndicator.h"

@interface TWGGridViewController (TESTS)

@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) TWGLoadingIndicator *loadingIndicator;

@end

@interface TWGGridViewControllerTests : XCTestCase

@property (nonatomic, strong) TWGGridViewController *viewController;

@end

@implementation TWGGridViewControllerTests

- (void)setUp
{
    [super setUp];
    self.viewController = [[TWGGridViewController alloc] init];
}

- (void)tearDown
{
    self.viewController = nil;
    [super tearDown];
}

- (void)testViewDidLoadCreatesCollectionView
{
    [self.viewController view];
    
    expect(self.viewController.collectionView).toNot.beNil();
}

- (void)testViewDidLoadAddsCollectionViewToView
{
    [self.viewController view];
    
    expect(self.viewController.collectionView.superview).toNot.beNil();
    expect(self.viewController.collectionView.superview).to.equal(self.viewController.view);
}

- (void)testViewDidLoadSetsInitialFrame
{
    [self.viewController view];
    expect(self.viewController.collectionView.frame).to.equal(self.viewController.view.bounds);
}

- (void)testViewDidLoadSetsCollectionViewProperties
{
    [self.viewController view];
    
    expect(self.viewController.collectionView.backgroundColor).to.equal([UIColor clearColor]);
}

- (void)testViewDidLoadSetsBasicFlowLayout
{
    [self.viewController view];
    
    expect(self.viewController.flowLayout).toNot.beNil();
    expect(self.viewController.flowLayout).to.beKindOf([UICollectionViewFlowLayout class]);
}

- (void)testWillRotateInvalidatesLayout
{
    [self.viewController view];
    id flowLayoutMock = OCMPartialMock(self.viewController.flowLayout);
    
    [self.viewController willRotateToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:0];
    
    OCMVerify([flowLayoutMock invalidateLayout]);
}

#pragma mark - TWGViewControllerState

- (void)testSettingStateToLoadingWhenThereIsNoContentSetsLoadingToYes
{
    [self.viewController view];
    
    self.viewController.loading = NO;
    
    self.viewController.state = TWGViewControllerStateLoading;
    
    expect(self.viewController.loading).to.beTruthy();
}

- (void)testSettingStateToEmptySetsLoadingToNo
{
    self.viewController.loading = YES;
    
    self.viewController.state = TWGViewControllerStateEmpty;
    
    expect(self.viewController.loading).to.beFalsy();
}

- (void)testSettingStateToEmptySetsEmptyViewVisible
{
    [self.viewController view];
    self.viewController.emptyView.hidden = YES;
    
    self.viewController.state = TWGViewControllerStateEmpty;
    
    expect(self.viewController.emptyView.hidden).to.beFalsy();
}

- (void)testSettingStateToEmptyDisablesScrollingOnCollectionView
{
    [self.viewController view];
    self.viewController.collectionView.scrollEnabled = YES;
    self.viewController.state = TWGViewControllerStateEmpty;
    
    expect(self.viewController.collectionView.scrollEnabled).to.beFalsy();
}

- (void)testSettingStateToEmptyDisablesBounceOnCollectionView
{
    [self.viewController view];
    self.viewController.collectionView.bounces = YES;
    self.viewController.state = TWGViewControllerStateEmpty;
    
    expect(self.viewController.collectionView.bounces).to.beFalsy();
}

- (void)testSettingStateToHasContentSetsLoadingToNo
{
    self.viewController.loading = YES;
    self.viewController.state = TWGViewControllerStateHasContent;
    expect(self.viewController.loading).to.beFalsy();
}

- (void)testSettingStateToHasContentHidesEmptyView
{
    [self.viewController view];
    self.viewController.emptyView.hidden = NO;
    self.viewController.state = TWGViewControllerStateHasContent;
    expect(self.viewController.emptyView.hidden).to.beTruthy();
}

- (void)testSettingStateToHasContentEnablesScrollingOnCollectionView
{
    [self.viewController view];
    self.viewController.collectionView.scrollEnabled = NO;
    self.viewController.state = TWGViewControllerStateHasContent;
    expect(self.viewController.collectionView.scrollEnabled).to.beTruthy();
}

- (void)testSettingStateToHasContentEnablesBouncingOnCollectionView
{
    [self.viewController view];
    self.viewController.collectionView.bounces = NO;
    self.viewController.state = TWGViewControllerStateHasContent;
    expect(self.viewController.collectionView.bounces).to.beTruthy();
}

#pragma mark - loading

- (void)testSettingLoadingYesHidesEmptyView
{
    [self.viewController view];
    self.viewController.emptyView.hidden = NO;
    self.viewController.loading = YES;
    
    expect(self.viewController.emptyView.hidden).to.beTruthy();
}

- (void)testSettingLoadingToYesShowsTheLoadingIndicator
{
    [self.viewController view];
    self.viewController.loadingIndicator.hidden = YES;
    self.viewController.loading = YES;
    
    expect(self.viewController.loadingIndicator.hidden).to.beFalsy();
}

- (void)testSettingLoadingToNoHidesTheLoadingIndicator
{
    [self.viewController view];
    self.viewController.loadingIndicator.hidden = YES;
    self.viewController.loading = NO;
    
    expect(self.viewController.loadingIndicator.hidden).to.beTruthy();
}
@end