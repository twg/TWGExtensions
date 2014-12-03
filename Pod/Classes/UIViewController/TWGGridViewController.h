#import "TWGViewControllerState.h"
#import "TWGEmptyView.h"

@class TWGGridLayout;

@interface TWGGridViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;
/**
 *  user can set the message of TWGEmptyView by setting the text of its label property
 */
@property (nonatomic, strong) TWGEmptyView *emptyView;
/**
 *  user can set empty view's bg color, default color is VC's view color
 */
@property (nonatomic, strong) UIColor *emptyViewBackgroundColor;
/**
 *  setting state will adjust the activity indicator and emptyView
 */
@property (nonatomic, assign) TWGViewControllerState state;

@end
