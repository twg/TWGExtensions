#import <UIKit/UIKit.h>

@class TWGSideViewController;
@protocol TWGSideViewControllerDelegate <NSObject>

@optional
- (void)didOpenSideView:(TWGSideViewController *)sideViewController;
- (void)didCloseSideView:(TWGSideViewController *)sideViewController byUserAction:(BOOL) flag;
@end

typedef NS_ENUM(NSInteger, TWGSideViewStyle) {
    TWGSideViewStyleLeft,
    TWGSideViewStyleRight
};

/**
 *  For an example of how implement TWGSideViewController, see TWGSideViewContainerViewController in the example
 */
@interface TWGSideViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *viewController;
@property (nonatomic, weak) id <TWGSideViewControllerDelegate> delegate;

- (instancetype)initWithViewController:(UIViewController *)viewController
                                 style:(TWGSideViewStyle)style
                             openWidth:(CGFloat)openWidth;

- (void)showViewControllerAnimated:(BOOL)animated;
- (void)hideViewControllerAnimated:(BOOL)animated;

@end
