//
//  UIView+TSNHeight.m
//  TSNGolf
//
//  Created by John Grant on 2014-03-11.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "UIView+TSNHeight.h"

@implementation UIView (TSNHeight)

- (void)forceLayoutInWidth:(CGFloat)width
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
