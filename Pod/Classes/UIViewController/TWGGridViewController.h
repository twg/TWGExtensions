#import "TWGViewControllerState.h"

@class TWGGridLayout;
@class TWGEmptyView;

@interface TWGGridViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) TWGEmptyView *emptyView;
@property (nonatomic, assign) TWGViewControllerState state;
@property (assign, nonatomic) BOOL loading;

@end
