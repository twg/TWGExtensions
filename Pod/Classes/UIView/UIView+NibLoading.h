//
//  UIView+NibLoading.h
//  TSNGolf
//
//  Created by John Grant on 2014-05-22.
//  Copyright (c) 2014 TSN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibLoading)

+ (instancetype)TSN_loadNib;
+ (id)TSN_loadNibViewFromClass:(Class)class;
+ (id)TSN_loadNibViewWithName:(NSString *)name;

@end
