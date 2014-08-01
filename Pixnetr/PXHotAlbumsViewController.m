//
//  PXHotAlbumsViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/07/30.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <CHTCollectionViewWaterfallLayout.h>
#import <SDWebImage/SDWebImageManager.h>

#import "PXHotAlbumsViewController.h"
#import "PXPhotosListViewController.h"
#import "PXAlbumCell.h"

static NSString *AlbumCellIdentifier = @"AlbumCellIdentifier";

@interface PXHotAlbumsViewController () <CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, getter = isLoadMore) BOOL loadMore;

@property (strong, nonatomic) NSMutableArray *albumsArray;
@property (nonatomic) NSUInteger currentPage;

@end

@implementation PXHotAlbumsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        
        self.title = @"熱門相簿";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"tab_hot.png"] tag:self.tabBarItem.tag];
        
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
    
    [self.collectionView registerClass:[PXAlbumCell class] forCellWithReuseIdentifier:AlbumCellIdentifier];
    
    [self _startRefresh];
    
    self.loadMore = NO;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"回去"
                                             style:UIBarButtonItemStylePlain
                                             target:nil
                                             action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.albumsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PXAlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AlbumCellIdentifier forIndexPath:indexPath];
    PXKAlbum *album = self.albumsArray[indexPath.item];
    
    cell.titleLabel.text = album.title;
    cell.authorLabel.text = album.author;
    cell.typeLabel.textLabel.text = album.categoryName;
    cell.countLabel.text = [NSString stringWithFormat:@"共 %d 張", album.photosCount];
    
    cell.albumPreviewImageView.image = nil;
    cell.avatarImageView.image = nil;
    
    cell.bookmarkButton.selected = NO;
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[PXKURLGenerator generateAvatarImageURLStringWithUsername:album.author size:(CGSize){ 46, 46 }]]
                                                    options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                    }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if ( ! error) {
                                                          cell.avatarImageView.image = image;
                                                      }
                                                  }];
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[PXKURLGenerator generateAlbumPreviewImageURLStringWithAlbum:album size:(CGSize){ 320, 320 }]]
                                                    options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                    }
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if ( ! error) {
                                                          cell.albumPreviewImageView.image = image;
                                                      }
                                                  }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PXPhotosListViewController *photosListViewController = [[PXPhotosListViewController alloc] initWithCollectionViewLayout:[[CHTCollectionViewWaterfallLayout alloc] init]];
    PXKAlbum *selectedAlbum = self.albumsArray[indexPath.item];
    
    photosListViewController.title = selectedAlbum.title;
    photosListViewController.album = selectedAlbum;
    
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
    return CGSizeMake(160, 223);
}

#pragma mark - Accessors

- (NSMutableArray *)albumsArray
{
    if ( ! _albumsArray) {
        _albumsArray = [NSMutableArray array];
    }
    
    return _albumsArray;
}

#pragma mark - Private Method

- (void)_startRefresh
{
    [self.refreshControl beginRefreshing];
    [PXKAlbum fetchHotAlbumsWithCategoryIDs:@[@"0"] page:1 perPage:20 resultBlock:^(NSArray *array, NSError *error) {
        if ( ! error) {
            
            self.albumsArray = [array mutableCopy];
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
    
    [PXKAlbum fetchHotAlbumsWithCategoryIDs:@[@"0"] page:(self.currentPage + 1) perPage:20 resultBlock:^(NSArray *array, NSError *error) {
        if ( ! error) {
            
            if (array.count > 0) {
                
                NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
                NSInteger currentEnd = self.albumsArray.count;
                
                for (NSInteger index = 0; index < array.count; index ++) {
                    [indexSet addIndex: currentEnd + index];
                }
                
                [self.albumsArray insertObjects:array atIndexes:indexSet];
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
