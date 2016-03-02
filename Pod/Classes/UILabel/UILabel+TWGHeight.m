
#import "UILabel+TWGHeight.h"

@implementation UILabel (TWGHeight)

- (CGFloat)twg_preferredHeightInWidth:(CGFloat)width
{
    CGSize size = CGSizeMake(width, HUGE_VALF);
    NSDictionary *attributes = @{NSFontAttributeName : self.font};
    NSStringDrawingOptions options = self.numberOfLines == 0 ? NSStringDrawingUsesLineFragmentOrigin : 0;
    CGRect rect = [self.text boundingRectWithSize:size options:options attributes:attributes context:NULL];
    return ceil(CGRectGetHeight(rect));
}

@end
