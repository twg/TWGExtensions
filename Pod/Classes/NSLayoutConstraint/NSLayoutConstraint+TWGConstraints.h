//
//  NSLayoutConstraint+TWGConstraints.h
//  The Working Group
//
//  Created by Brian Gilham on 2014-12-01.
//  Copyright (c) 2014 The Working Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (TWGConstraints)

+ (NSArray *)constraintsForTwoColumnHorizontalWithLeftView:(UIView *)left
                                                 rightView:(UIView *)right
                                               spacing:(CGFloat)spacing;

+ (NSArray *)constraintsForFullWidthHorizontalWithView:(UIView *)view;

+ (NSLayoutConstraint *)constraintForEqualWidthWithFirstView:(UIView *)firstView
                                                  secondView:(UIView *)secondView;
@end
