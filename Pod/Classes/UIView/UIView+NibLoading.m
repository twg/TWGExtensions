//
//  UIView+NibLoading.m
//  TSNGolf
//
//  Created by John Grant on 2014-05-22.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import "UIView+NibLoading.h"

@implementation UIView (NibLoading)

+ (id)TSN_loadNibViewWithName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] firstObject];
}

+ (id)TSN_loadNibViewFromClass:(Class)class
{
    return [self TSN_loadNibViewWithName:NSStringFromClass(class)];
}

+ (instancetype)TSN_loadNib
{
    return [self TSN_loadNibViewFromClass:[self class]];
}

@end
