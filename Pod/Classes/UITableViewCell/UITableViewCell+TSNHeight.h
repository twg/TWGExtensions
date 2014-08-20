//
//  UITableViewCell+TSNHeight.h
//  TSNGolf
//
//  Created by John Grant on 2014-03-10.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (TSNHeight)

- (CGFloat)heightInWidth:(CGFloat)width decorationBlock:(void(^)(void))decoration;

@end
