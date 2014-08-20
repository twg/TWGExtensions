//
//  UILabel+TWGDrawing.m
//  TSNGolf
//
//  Created by John Grant on 2014-05-05.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "UILabel+TWGDrawing.h"

@implementation UILabel (TWGDrawing)

- (CGFloat)TWG_preferredHeightInWidth:(CGFloat)width
{
    CGSize size = CGSizeMake(width, HUGE_VALF);
    NSDictionary *attributes = @{ NSFontAttributeName: self.font };
    NSStringDrawingOptions options = self.numberOfLines == 0 ? NSStringDrawingUsesLineFragmentOrigin : 0;
    CGRect rect = [self.text boundingRectWithSize:size
                                          options:options
                                       attributes:attributes
                                          context:NULL];
    return ceil(CGRectGetHeight(rect));
}

@end
