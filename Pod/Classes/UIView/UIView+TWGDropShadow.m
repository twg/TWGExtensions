
#import "UIView+TWGDropShadow.h"

@implementation UIView (DropShadow)

- (void)applyDropShadow
{
    CALayer *cardLayer = self.layer;
    cardLayer.cornerRadius = 5.0;
    cardLayer.shadowOffset = CGSizeMake(0, 0);
    cardLayer.shadowColor = [[UIColor blackColor] CGColor];
    cardLayer.shadowRadius = 4.0f;
    cardLayer.shadowOpacity = 0.5f;
}

@end