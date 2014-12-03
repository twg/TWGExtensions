//
//  TWGRandomDataSource.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/1/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

#import "TWGBasicDataSource.h"

@implementation TWGBasicDataSource
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    self = [super init];
    if (self) {
        _content = @[];
        [collectionView registerClass:[UICollectionViewCell class]
           forCellWithReuseIdentifier:@"cell"];
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
