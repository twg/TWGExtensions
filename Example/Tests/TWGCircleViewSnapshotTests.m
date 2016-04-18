#import "FBSnapshotTestCase.h"
#import "UIView+TWGHeight.h"
#import "UIView+TWGCircleView.h"

@interface TWGCircleViewSnapshotTests : FBSnapshotTestCase

@property (nonatomic, strong) UIView *view;

@end

@implementation TWGCircleViewSnapshotTests

- (void)setUp
{
    [super setUp];
    self.recordMode = NO;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)tearDown
{
    self.view = nil;
    [super tearDown];
}

- (void)testDefaultLayout
{
    [self.view twg_circleView];
    FBSnapshotVerifyView(self.view, nil);
}

@end
