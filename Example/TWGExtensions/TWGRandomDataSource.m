//
//  TWGRandomDataSource.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/1/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

#import "TWGRandomDataSource.h"

@implementation TWGRandomDataSource
- (instancetype)init
{
    self = [super init];
    if (self) {
        _content = @[];
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.content.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                            forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blueColor];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
@end
