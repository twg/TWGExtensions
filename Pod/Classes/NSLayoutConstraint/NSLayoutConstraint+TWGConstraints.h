
#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (TWGConstraints)

+ (NSArray *)constraintsForTwoColumnHorizontalWithLeftView:(UIView *)left
                                                 rightView:(UIView *)right
                                                   spacing:(CGFloat)spacing;

+ (NSArray *)constraintsForFullWidthHorizontalWithView:(UIView *)view;

+ (NSLayoutConstraint *)constraintForEqualWidthWithFirstView:(UIView *)firstView secondView:(UIView *)secondView;
@end
