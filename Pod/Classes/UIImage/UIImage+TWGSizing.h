
@import UIKit;

@interface UIImage (TWGSizing)

- (UIImage *)twg_resizedImageToSize:(CGSize)destinationSize;
- (UIImage *)twg_resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
