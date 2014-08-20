//
//  UITableViewCell+TSNHeight.m
//  TSNGolf
//
//  Created by John Grant on 2014-03-10.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "UITableViewCell+TSNHeight.h"

@implementation UITableViewCell (TSNHeight)

- (CGFloat)heightInWidth:(CGFloat)width decorationBlock:(void(^)(void))decoration
{
    // Adjust the cell frame for the current tableview width
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    
    if (decoration) {
        decoration();
    }
    
    // Force layout
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    // Calculate height + 1 for the cell separator
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}

@end
