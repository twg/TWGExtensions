//
//  TWGProductGridViewController.m
//  TWGExtensions
//
//  Created by Andrew McCallum14 on 12/1/14.
//  Copyright (c) 2014 John Grant. All rights reserved.
//

#import "TWGProductGridViewController.h"
#import "TWGBasicDataSource.h"
#import "TWGGridLayout.h"

@interface TWGProductGridViewController ()

@property (strong, nonatomic) TWGBasicDataSource *dataSource;
@end

@implementation TWGProductGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [[TWGBasicDataSource alloc] initWithCollectionView:self.collectionView];
    self.collectionView.dataSource = self.dataSource;
    self.emptyView.label.text = @"No Data";
    self.emptyViewBackgroundColor = [UIColor greenColor];
    [self download];
}

- (void)download
{
    [self downloadWithCompletion:^() {
        self.state = TWGViewControllerStateHasContent;
        [self.collectionView reloadData];
    }];
}

- (void)downloadWithCompletion:(void(^)(void))completion
{
    self.state = TWGViewControllerStateLoading;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.dataSource.content = @[@1,@2,@3,@4,@5];
        completion();
    });
}

- (UICollectionViewFlowLayout *)flowLayout
{
    return [[TWGGridLayout alloc] init];
}
@end
