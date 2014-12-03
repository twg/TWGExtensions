//
//  TWGRandomDataSource.h
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/1/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWGBasicDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *content;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
