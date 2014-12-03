//
//  NSLayoutConstraint+TWGConstraints.m
//  The Working Group
//
//  Created by Brian Gilham on 2014-12-01.
//  Copyright (c) 2014 The Working Group. All rights reserved.
//

#import "NSLayoutConstraint+TWGConstraints.h"

@implementation NSLayoutConstraint (TWGConstraints)

+ (NSArray *)constraintsForTwoColumnHorizontalWithLeftView:(UIView *)left
                                                 rightView:(UIView *)right
                                               spacing:(CGFloat)spacingValue
{
    NSDictionary *views = NSDictionaryOfVariableBindings(left, right);
    NSNumber *spacing = @(spacingValue);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(spacing);
    
    NSString *format = @"|[left]-(spacing@999)-[right]|";
    return [NSLayoutConstraint constraintsWithVisualFormat:format
                                                   options:NSLayoutFormatAlignAllTop
                                                   metrics:metrics
                                                     views:views];
}

+ (NSArray *)constraintsForFullWidthHorizontalWithView:(UIView *)view
{
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    return
     [NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|"
                                             options:0
                                             metrics:nil
                                               views:views];
}

+ (NSLayoutConstraint *)constraintForEqualWidthWithFirstView:(UIView *)firstView
                                                  secondView:(UIView *)secondView
{
    return [NSLayoutConstraint constraintWithItem:secondView
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:firstView
                                        attribute:NSLayoutAttributeWidth
                                       multiplier:1
                                         constant:0];
}

@end
