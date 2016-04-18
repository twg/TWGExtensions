//
//  UIView+TWGCircleView.m
//  Pods
//
//  Created by Alex on 2016-04-18.
//
//

#import "UIView+TWGCircleView.h"

@implementation UIView (TWGCircleView)

- (void)twg_circleView
{
    [self remask];
}

- (void)remask
{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];

    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = circlePath.CGPath;

    self.layer.mask = mask;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

@end
