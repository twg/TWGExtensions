//
//  UIImage+Extensions.h
//  TSN Hockey
//
//  Created by Brian Gilham on 12/30/2013.
//  Copyright (c) 2013 TSN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

- (UIImage *)resizedImageToSize:(CGSize)destinationSize;
- (UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
