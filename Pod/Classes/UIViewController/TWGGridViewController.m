#import "TWGGridViewController.h"
#import "TWGLoadingIndicator.h"

@interface TWGGridViewController ()

@property (nonatomic, strong) TWGLoadingIndicator *loadingIndicator;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) BOOL loading;

@end

@implementation TWGGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self addSubviews];
}

- (void)addSubviews
{
    [self addEmptyView];
    [self setupCollectionView];
    [self setupLoadingIndicator];
}

- (void)addEmptyView
{
    [self.view addSubview:self.emptyView];
    [self constrainView:self.emptyView];
}

- (void)setupCollectionView
{
    [self.view addSubview:self.collectionView];
    [self constrainView:self.collectionView];
}

- (void)setupLoadingIndicator
{
    self.loadingIndicator = [[TWGLoadingIndicator alloc] init];
    self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.loadingIndicator.hidden = YES;
    [self.view insertSubview:self.loadingIndicator aboveSubview:self.collectionView];
    
    NSLayoutConstraint *loadingIndicatorCenterX = [NSLayoutConstraint constraintWithItem:self.loadingIndicator
                                                                               attribute:NSLayoutAttributeCenterX
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeCenterX
                                                                              multiplier:1
                                                                                constant:0];
    
    NSLayoutConstraint *loadingIndicatorCenterY = [NSLayoutConstraint constraintWithItem:self.loadingIndicator
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:self.view
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    
     NSLayoutConstraint *loadingIndicatorWidth = [NSLayoutConstraint constraintWithItem:self.loadingIndicator
                                                                              attribute:NSLayoutAttributeWidth
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:nil
                                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                                             multiplier:1
                                                                               constant:self.loadingIndicator.intrinsicContentSize.width];
                                                   
    NSLayoutConstraint *loadingIndicatorHeight = [NSLayoutConstraint constraintWithItem:self.loadingIndicator
                                                                               attribute:NSLayoutAttributeHeight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:nil
                                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                                              multiplier:1
                                                                                constant:self.loadingIndicator.intrinsicContentSize.height];
    [self.view addConstraints:@[
                                loadingIndicatorCenterX,
                                loadingIndicatorCenterY,
                                loadingIndicatorWidth,
                                loadingIndicatorHeight
                                ]];
}

- (void)constrainView:(UIView *)view
{
    NSString *format;
    NSArray *constraints;
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    
    format = @"|[view]|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
    
    format = @"V:|[view]|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
    [self.view addConstraints:constraints];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.flowLayout invalidateLayout];
}

#pragma mark - "Setters"

- (void)setState:(TWGViewControllerState)state
{
    _state = state;
    
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = YES;
    
    switch (_state) {
        case TWGViewControllerStateLoading:
            self.loading = YES;
            break;
        case TWGViewControllerStateEmpty:
            self.loading = NO;
            self.emptyView.hidden = NO;
            self.collectionView.scrollEnabled = NO;
            self.collectionView.bounces = NO;
            break;
        case TWGViewControllerStateHasContent:
            self.emptyView.hidden = YES;
            self.loading = NO;
            break;
    }
}

- (void)setLoading:(BOOL)loading
{
    if (_loading != loading) {
        if (loading) {
            self.emptyView.hidden = YES;
            self.loadingIndicator.hidden = NO;
        } else {
            self.loadingIndicator.hidden = YES;
        }
        
        _loading = loading;
    }
}

#pragma mark - Lazy Loaders

- (TWGEmptyView *)emptyView
{
    if (!_emptyView) {
        self.emptyView = [[TWGEmptyView alloc] init];
        self.emptyView.translatesAutoresizingMaskIntoConstraints = NO;
        self.emptyView.backgroundColor = [UIColor whiteColor];
    }
    return _emptyView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                 collectionViewLayout:self.flowLayout];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
