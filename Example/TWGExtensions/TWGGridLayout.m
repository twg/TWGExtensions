//
//  TWGGridLayout.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/2/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

#import "TWGGridLayout.h"

#define IS_IPAD     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

CGFloat const TWGGridLayoutSmallItemWidth = 120.0f;
CGFloat const TWGGridLayoutSmallItemHeight = 238.0f;
CGFloat const TWGGridLayoutSmallEdgeInsetsTop = 30.0f; // to give space between theme header and cards
CGFloat const TWGGridLayoutSmallEdgeInsetsBottom = 30.0f; // to give space between theme header and cards
CGFloat const TWGGridLayoutSmallEdgeInsetsLeft = 30.0f;
CGFloat const TWGGridLayoutSmallEdgeInsetsRight = 30.0f;
CGFloat const TWGGridLayoutSmallMinInterItemSpacing = 20.0f;
CGFloat const TWGGridLayoutSmallMinLineSpacing = 30.0f;

CGFloat const TWGGridLayoutLargeItemWidth = 220.0f;
CGFloat const TWGGridLayoutLargeItemHeight = 410.0f;
CGFloat const TWGGridLayoutLargeEdgeInsetsTop = 34.0f;
CGFloat const TWGGridLayoutLargeEdgeInsetsBottom = 34.0f;
CGFloat const TWGGridLayoutLargeEdgeInsetsLeft = 34.0f;
CGFloat const TWGGridLayoutLargeEdgeInsetsRight = 34.0f;
CGFloat const TWGGridLayoutLargeMinInterItemSpacing = 20.0f;
CGFloat const TWGGridLayoutLargeMinLineSpacing = 34.0f;

@implementation TWGGridLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (IS_IPAD) {
            [self initLayoutLarge];
        } else {
            [self initLayoutSmall];
        }
    }
    return self;
}

- (void)initLayoutSmall
{
    self.itemSize = CGSizeMake(TWGGridLayoutSmallItemWidth, TWGGridLayoutSmallItemHeight);
    self.sectionInset = UIEdgeInsetsMake(TWGGridLayoutSmallEdgeInsetsTop,
                                         TWGGridLayoutSmallEdgeInsetsLeft,
                                         TWGGridLayoutSmallEdgeInsetsBottom,
                                         TWGGridLayoutSmallEdgeInsetsRight);
    self.minimumInteritemSpacing = TWGGridLayoutSmallMinInterItemSpacing;
    self.minimumLineSpacing = TWGGridLayoutSmallMinLineSpacing;
    self.style = TWGGridLayoutStyleSmall;
}

- (void)initLayoutLarge
{
    self.itemSize = CGSizeMake(TWGGridLayoutLargeItemWidth, TWGGridLayoutLargeItemHeight);
    self.sectionInset = UIEdgeInsetsMake(TWGGridLayoutLargeEdgeInsetsTop,
                                         TWGGridLayoutLargeEdgeInsetsLeft,
                                         TWGGridLayoutLargeEdgeInsetsBottom,
                                         TWGGridLayoutLargeEdgeInsetsRight);
    self.minimumInteritemSpacing = TWGGridLayoutLargeMinInterItemSpacing;
    self.minimumLineSpacing = TWGGridLayoutLargeMinLineSpacing;
    self.style = TWGGridLayoutStyleLarge;
}

@end
