//
//  TWGGridLayout.h
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/2/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, TWGGridLayoutStyle) {
    TWGGridLayoutStyleSmall,
    TWGGridLayoutStyleLarge,
};

extern CGFloat const TWGGridLayoutSmallItemWidth;
extern CGFloat const TWGGridLayoutSmallItemHeight;
extern CGFloat const TWGGridLayoutSmallEdgeInsetsTop;
extern CGFloat const TWGGridLayoutSmallEdgeInsetsLeft;
extern CGFloat const TWGGridLayoutSmallEdgeInsetsRight;
extern CGFloat const TWGGridLayoutSmallEdgeInsetsBottom;
extern CGFloat const TWGGridLayoutSmallMinInterItemSpacing;
extern CGFloat const TWGGridLayoutSmallMinLineSpacing;

extern CGFloat const TWGGridLayoutLargeItemWidth;
extern CGFloat const TWGGridLayoutLargeItemHeight;
extern CGFloat const TWGGridLayoutLargeEdgeInsetsTop;
extern CGFloat const TWGGridLayoutLargeEdgeInsetsBottom;
extern CGFloat const TWGGridLayoutLargeEdgeInsetsLeft;
extern CGFloat const TWGGridLayoutLargeEdgeInsetsRight;
extern CGFloat const TWGGridLayoutLargeMinInterItemSpacing;
extern CGFloat const TWGGridLayoutLargeMinLineSpacing;

@interface TWGGridLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) TWGGridLayoutStyle style;

@end
