
#import "UIView+TWGHeight.h"

@implementation UIView (TWGHeight)

- (void)twg_forceLayoutInWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    frame.size.height = height;
    self.frame = frame;
}

@end
