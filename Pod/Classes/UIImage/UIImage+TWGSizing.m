
#import "UIImage+TWGSizing.h"

@implementation UIImage (TWGSizing)

- (UIImage *)twg_resizedImageToSize:(CGSize)destinationSize
{
    CGImageRef sourceImageRef = self.CGImage;
    CGSize sourceImageSize = CGSizeMake(CGImageGetWidth(sourceImageRef), CGImageGetHeight(sourceImageRef));
    
    if(CGSizeEqualToSize(sourceImageSize, destinationSize)) {
        return self;
    } else {
        CGFloat scaleRatio = destinationSize.width / sourceImageSize.width;
        UIImageOrientation sourceImageOrientation = self.imageOrientation;
        CGAffineTransform transform = CGAffineTransformIdentity;
        switch(sourceImageOrientation) {
            case UIImageOrientationUp: {
                transform = CGAffineTransformIdentity;
                break;
            }
                
            case UIImageOrientationUpMirrored: {
                transform = CGAffineTransformMakeTranslation(sourceImageSize.width, 0.0);
                transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
                break;
            }
                
            case UIImageOrientationDown: {
                transform = CGAffineTransformMakeTranslation(sourceImageSize.width, sourceImageSize.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
            }
                
            case UIImageOrientationDownMirrored: {
                transform = CGAffineTransformMakeTranslation(0.0, sourceImageSize.height);
                transform = CGAffineTransformScale(transform, 1.0, -1.0);
                break;
            }
                
            case UIImageOrientationLeftMirrored: {
                destinationSize = CGSizeMake(destinationSize.height, destinationSize.width);
                transform = CGAffineTransformMakeTranslation(sourceImageSize.height, sourceImageSize.width);
                transform = CGAffineTransformScale(transform, -1.0f, 1.0f);
                transform = CGAffineTransformRotate(transform, 3.0f * M_PI_2);
                break;
            }
                
                
            case UIImageOrientationLeft: {
                destinationSize = CGSizeMake(destinationSize.height, destinationSize.width);
                transform = CGAffineTransformMakeTranslation(0.0f, sourceImageSize.width);
                transform = CGAffineTransformRotate(transform, 3.0f * M_PI_2);
                break;
            }
                
                
            case UIImageOrientationRightMirrored: {
                destinationSize = CGSizeMake(destinationSize.height, destinationSize.width);
                transform = CGAffineTransformMakeScale(-1.0f, 1.0f);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
            }
                
                
            case UIImageOrientationRight: {
                destinationSize = CGSizeMake(destinationSize.height, destinationSize.width);
                transform = CGAffineTransformMakeTranslation(sourceImageSize.height, 0.0f);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
            }
              
            default: {
                [NSException raise:NSInternalInconsistencyException format:@"Could not find a valid image orientation."];
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(destinationSize, NO, self.scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        if(sourceImageOrientation == UIImageOrientationRight || sourceImageOrientation == UIImageOrientationLeft) {
            CGContextScaleCTM(context, -scaleRatio, scaleRatio);
            CGContextTranslateCTM(context, -sourceImageSize.height, 0.0f);
        } else {
            CGContextScaleCTM(context, scaleRatio, -scaleRatio);
            CGContextTranslateCTM(context, 0.0f, -sourceImageSize.height);
        }
        
        CGContextConcatCTM(context, transform);
        
        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0.0f, 0.0f, sourceImageSize.width, sourceImageSize.height), sourceImageRef);
        UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return resizedImage;
    }
}

- (UIImage *)twg_resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
    CGImageRef sourceImageRef = self.CGImage;
    CGSize sourceImageSize = CGSizeMake(CGImageGetWidth(sourceImageRef), CGImageGetHeight(sourceImageRef));
    
    UIImageOrientation sourceImageOrientation = self.imageOrientation;
    switch(sourceImageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: {
            boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
            break;
        }
            
        default: {
            break;
        }
    }
    
    CGSize destinationImageSize;
    if((!scale && sourceImageSize.width < boundingSize.width) && (sourceImageSize.height < boundingSize.height)) {
        destinationImageSize = sourceImageSize;
    } else {
        CGFloat widthRatio = boundingSize.width / sourceImageSize.width;
        CGFloat heightRatio = boundingSize.height / sourceImageSize.height;
        
        if(widthRatio < heightRatio) {
            destinationImageSize = CGSizeMake(boundingSize.width, floorf(sourceImageSize.height * widthRatio));
        } else {
            destinationImageSize = CGSizeMake(floorf(sourceImageSize.width * heightRatio), boundingSize.height);
        }
    }
    
    return [self twg_resizedImageToSize:destinationImageSize];
}

@end
