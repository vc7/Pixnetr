//
//  PXPhotoListViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/07/31.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <CHTCollectionViewWaterfallLayout.h>
#import <SDWebImage/SDWebImageManager.h>

#import "PXPhotosListViewController.h"
#import "PXPhotoLightBoxViewController.h"
#import "PXListedPhotoCell.h"

static NSString *PhotoCellIdentifier = @"PhotoCellIdentifier";

@interface PXPhotosListViewController () <CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, getter = isLoadMore) BOOL loadMore;

@property (strong, nonatomic) NSMutableArray *photosArray;
@property (nonatomic) NSUInteger currentPage;

@end

@implementation PXPhotosListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(_startRefresh) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:self.refreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[PXListedPhotoCell class] forCellWithReuseIdentifier:PhotoCellIdentifier];
    
    self.loadMore = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回去" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PXListedPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
    PXKPhoto *photo = self.photosArray[indexPath.item];
    
    CGFloat photoRatio = [((PXKPhoto *)self.photosArray[indexPath.item]).photoRatio floatValue];
    
    cell.titleLabel.text = photo.title;
    cell.photoRatio = photoRatio;
    cell.mainPhotoImageView.image = nil;
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[PXKURLGenerator generatePhotoImageURLStringWithPhoto:photo size:(CGSize){ 320, 320/photoRatio }]]
                                                    options:0
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       NSLog(@"%d", receivedSize);
                                                   }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if ( ! error) {
                                                          cell.mainPhotoImageView.image = image;
                                                      }
                                                  }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PXPhotoLightBoxViewController *photosListViewController = [[PXPhotoLightBoxViewController alloc] initWithStyle:UITableViewStylePlain];
    PXKPhoto *selectedPhoto = self.photosArray[indexPath.item];
    
    photosListViewController.title = selectedPhoto.title;
    photosListViewController.photo = self.photosArray[indexPath.item];
    
    [self.navigationController pushViewController:photosListViewController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height && ! [self isLoadMore]) {
        
        [self _loadMore];
    }
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat photoRatio = [((PXKPhoto *)self.photosArray[indexPath.item]).photoRatio floatValue];
    return (CGSize){ 160, 160/photoRatio + 60 };
}

#pragma mark - Accessors

- (void)setAlbum:(PXKAlbum *)album
{
    if (_album != album) {
        _album = album;
        
        [self _startRefresh];
    }
}

#pragma mark - Private Method

- (void)_startRefresh
{
    [self.refreshControl beginRefreshing];
    [PXKPhoto fetchPhotosWithAlbum:self.album page:1 perPage:20 resultBlock:^(NSArray *array, NSError *error) {
        if ( ! error) {
            
            self.photosArray = [array mutableCopy];
            self.currentPage = 1;
            
            [self.collectionView reloadData];
        } else {
            NSLog(@"something wrong: %@", [error localizedDescription]);
        }
        
        [self.refreshControl endRefreshing];
    }];
}

- (void)_loadMore
{
    self.loadMore = YES;
    
    [PXKPhoto fetchPhotosWithAlbum:self.album page:(self.currentPage + 1) perPage:20 resultBlock:^(NSArray *array, NSError *error) {
        if ( ! error) {
            
            if (array.count > 0) {
                
                NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
                NSInteger currentEnd = self.photosArray.count;
                
                for (NSInteger index = 0; index < array.count; index ++) {
                    [indexSet addIndex: currentEnd + index];
                }
                
                [self.photosArray insertObjects:array atIndexes:indexSet];
                [self.collectionView reloadData];
                
                self.currentPage += 1;
            }
            
        } else {
            NSLog(@"something wrong: %@", [error localizedDescription]);
        }
        
        self.loadMore = NO;
        
    }];
}

@end
