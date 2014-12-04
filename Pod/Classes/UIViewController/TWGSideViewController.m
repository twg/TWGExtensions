#import "TWGSideViewController.h"

@interface TWGSideViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, assign) TWGSideViewStyle style;
@property (nonatomic, assign) CGFloat openWidth;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) UIView *fadeView;
@property (nonatomic, strong) UIView *contentBackgroundView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BOOL closeByUserAction;
@end

static CGFloat TWGSideViewFadeViewTargetAlphaDefault = 0.5f;
static CGFloat TWGSideViewContentBackgroundViewAlphaDefault = 0.8f;

@implementation TWGSideViewController

- (instancetype)initWithViewController:(UIViewController *)viewController
                                 style:(TWGSideViewStyle)style
                             openWidth:(CGFloat)openWidth;
{
    self = [super init];
    if (self) {
        _style = style;
        _viewController = viewController;
        _openWidth = openWidth;
        _sideViewTargetAlpha = TWGSideViewFadeViewTargetAlphaDefault;
        _contentBackgroundViewAlpha = TWGSideViewContentBackgroundViewAlphaDefault;
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;
    
    self.fadeView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.fadeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.fadeView.backgroundColor = [UIColor blackColor];
    self.fadeView.alpha = 0;
    [self.view addSubview:self.fadeView];
    
    self.contentBackgroundView = [[UIView alloc] initWithFrame:[self targetContentRect]];
    self.contentBackgroundView.autoresizingMask = [self autoresizingMaskForStyle:self.style];
    self.contentBackgroundView.backgroundColor = [UIColor whiteColor];
    self.contentBackgroundView.alpha = self.contentBackgroundViewAlpha;
    [self.view addSubview:self.contentBackgroundView];
}

- (CGRect)targetContentRect
{
    if (self.style == TWGSideViewStyleLeft) {
        return CGRectMake(0, 0, self.openWidth, CGRectGetHeight(self.view.bounds));
    }
    
    return CGRectMake(CGRectGetWidth(self.view.bounds) - self.openWidth,
                      0,
                      self.openWidth,
                      CGRectGetHeight(self.view.bounds));
}

- (CGRect)hiddenContentRect
{
    if (self.style == TWGSideViewStyleLeft) {
        return CGRectMake(-self.openWidth, 0, self.openWidth, CGRectGetHeight(self.view.bounds));
    }
    
    return CGRectMake(CGRectGetWidth(self.view.bounds), 0, self.openWidth, CGRectGetHeight(self.view.bounds));
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addViewControllerAsChild];
    
    [self addTapGestureToDismiss];
    [self addPanGestureToDismiss];
    [self setViewControllerToHiddenPosition];
    [self.view layoutIfNeeded];
}

- (UIViewAutoresizing)autoresizingMaskForStyle:(TWGSideViewStyle)style
{
    NSUInteger sideMask = self.style == TWGSideViewStyleLeft ?
        UIViewAutoresizingFlexibleRightMargin : UIViewAutoresizingFlexibleLeftMargin;
    return sideMask | UIViewAutoresizingFlexibleHeight;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.closeByUserAction = NO;
}

- (void)addViewControllerAsChild
{
    [self addChildViewController:self.viewController];
    self.viewController.view.autoresizingMask = [self autoresizingMaskForStyle:self.style];
    [self.view addSubview:self.viewController.view];
    [self.viewController didMoveToParentViewController:self];
}

- (void)addTapGestureToDismiss
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    self.tapGesture = tap;
}

- (void)addPanGestureToDismiss
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanView:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.panGesture = pan;
}

- (void)didTapView:(UITapGestureRecognizer *)recognizer
{
    self.closeByUserAction = YES;
    [self hideViewControllerAnimated:YES];
}

- (void)didPanView:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [recognizer translationInView:self.view];
        [self animateContentWithDelta:translation.x];
    }else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        [self finishAnimationWithVelocity:velocity.x];
    }
}

- (void)animateContentWithDelta:(CGFloat)deltaX
{
    CGFloat percentagePanned = deltaX / self.openWidth;
    
    CGRect currentFrame = [self targetContentRect];
    currentFrame.origin.x = [self clampedXFromProposedX:currentFrame.origin.x + deltaX];
    self.viewController.view.frame = currentFrame;
    self.contentBackgroundView.frame = currentFrame;
    
    if ([self shouldChangeAlphaBasedOnPercentagePanned:percentagePanned]) {
        percentagePanned = percentagePanned < 0 ? -percentagePanned : percentagePanned;
        self.fadeView.alpha = MIN(self.sideViewTargetAlpha,
                                  (1-percentagePanned) * self.sideViewTargetAlpha);
    }
}

- (BOOL)shouldChangeAlphaBasedOnPercentagePanned:(CGFloat)percentagePanned
{
    return (self.style == TWGSideViewStyleLeft && percentagePanned < 0) ||
           (self.style == TWGSideViewStyleRight && percentagePanned);
}

- (CGFloat)clampedXFromProposedX:(CGFloat)proposedX
{
    CGRect hiddenFrame = [self hiddenContentRect];
    CGRect targetFrame = [self targetContentRect];
    if (self.style == TWGSideViewStyleLeft) {
        return MAX(hiddenFrame.origin.x, MIN(proposedX, targetFrame.origin.x));
    }
    
    return MAX(targetFrame.origin.x, MIN(proposedX, hiddenFrame.origin.x));
}

- (void)finishAnimationWithVelocity:(CGFloat)velocityX
{
    CGRect currentFrame = self.viewController.view.frame;
    if ([self shouldAnimatedClosedFromPosition:currentFrame.origin.x withVelocity:velocityX]) {
        CGFloat pointsLeftToMove = [self hiddenContentRect].origin.x - currentFrame.origin.x;
        CGFloat duration = pointsLeftToMove / velocityX;
        self.closeByUserAction = YES;
        [self animateToFrame:[self hiddenContentRect] fadeOut:YES duration:duration];
    }else{
        [self animateToFrame:[self targetContentRect] fadeOut:NO];
    }
}

- (BOOL)shouldAnimatedClosedFromPosition:(CGFloat)originX withVelocity:(CGFloat)velocityX
{
    if (self.style == TWGSideViewStyleLeft) {
        CGRect targetRect = [self hiddenContentRect];
        return originX <= targetRect.origin.x + 0.5*targetRect.size.width;
    }else{
        CGRect targetRect = [self targetContentRect];
        return originX >= targetRect.origin.x + 0.5*targetRect.size.width;
    }
    
    return NO;
}

- (void)setViewControllerToHiddenPosition
{
    self.contentBackgroundView.frame = [self hiddenContentRect];
    self.viewController.view.frame = [self hiddenContentRect];
}

- (void)showViewControllerAnimated:(BOOL)animated
{
    [self animateToFrame:[self targetContentRect] fadeOut:NO];
}

- (void)hideViewControllerAnimated:(BOOL)animated
{
    [self animateToFrame:[self hiddenContentRect] fadeOut:YES];
}

- (void)animateToFrame:(CGRect)targetFrame fadeOut:(BOOL)fadeOut
{
    [self animateToFrame:targetFrame fadeOut:fadeOut duration:0.3f];
}
- (void)animateToFrame:(CGRect)targetFrame fadeOut:(BOOL)fadeOut duration:(CGFloat)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.fadeView.alpha = fadeOut ? 0 : self.sideViewTargetAlpha;
        self.contentBackgroundView.frame = targetFrame;
        self.viewController.view.frame = targetFrame;
    } completion:^(BOOL finished) {
        [self notifyDelegateOfCompletion];
    }];
}

- (void)notifyDelegateOfCompletion
{
    if ([self isSideViewCurrentlyOpen]) {
        if ([self.delegate respondsToSelector:@selector(didOpenSideView:)]) {
            [self.delegate didOpenSideView:self];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didCloseSideView:byUserAction:)]) {
                [self.delegate didCloseSideView:self byUserAction:self.closeByUserAction];
        }
    }
}

- (BOOL)isSideViewCurrentlyOpen
{
    if (self.style == TWGSideViewStyleLeft) {
        return CGRectGetMinX(self.viewController.view.frame) >= 0;
    }
    
    return CGRectGetMinX(self.viewController.view.frame) < CGRectGetWidth(self.view.bounds);
}

@end

