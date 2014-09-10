//
//  UIImage+TWGImage.m
//  COOLS
//
//  Created by John Grant on 2014-09-10.
//  Copyright (c) 2014 COOLS. All rights reserved.
//

#import "UIImage+TWGImage.h"

@implementation UIImage (TWGImage)

+ (UIImage *)twg_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
