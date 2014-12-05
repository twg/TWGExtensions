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

@interface TWGSideViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *viewController;
@property (nonatomic, weak) id <TWGSideViewControllerDelegate> delegate;
@property (nonatomic, assign) CGFloat sideViewTargetAlpha;
@property (nonatomic, assign) CGFloat contentBackgroundViewAlpha;

/**
 *  Initialize the side view controller
 *
 *  @param viewController view controller to be displayed inside
 *  @param style          direction side view controller comes from
 *  @param openWidth      width of side view controller
 *
 */
- (instancetype)initWithViewController:(UIViewController *)viewController
                                 style:(TWGSideViewStyle)style
                             openWidth:(CGFloat)openWidth;

- (void)showViewControllerAnimated:(BOOL)animated;
- (void)hideViewControllerAnimated:(BOOL)animated;

@end
