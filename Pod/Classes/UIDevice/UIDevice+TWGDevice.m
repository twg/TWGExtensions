//
//  UIDevice+TWGDevice.m
//  The Working Group
//
//  Created by Brian Gilham on 2014-11-10.
//  Copyright (c) 2014 COOLS. All rights reserved.
//

#import "UIDevice+TWGDevice.h"

@implementation UIDevice (TWGDevice)

+ (BOOL)isPhone
{
    return [[self currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (BOOL)isPad
{
	return [[self currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

@end
