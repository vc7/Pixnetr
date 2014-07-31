//
//  PXHotAlbumsViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/07/30.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <CHTCollectionViewWaterfallLayout.h>

#import "PXHotAlbumsViewController.h"
#import "PXPhotosListViewController.h"
#import "PXAlbumCell.h"

static NSString *AlbumCellIdentifier = @"AlbumCellIdentifier";

@interface PXHotAlbumsViewController () <CHTCollectionViewDelegateWaterfallLayout>

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic, getter = isLoadMore) BOOL loadMore;

@property (strong, nonatomic) NSMutableArray *albumsArray;
@property (nonatomic) NSUInteger currentPage;

@property (strong, nonatomic) PXPhotosListViewController *photosListViewController;

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
    
    self.title = @"熱門相簿";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (PXPhotosListViewController *)photosListViewController
{
    if ( ! _photosListViewController) {
        _photosListViewController = [[PXPhotosListViewController alloc] initWithCollectionViewLayout:[[CHTCollectionViewWaterfallLayout alloc] init]];
    }
    return _photosListViewController;
}

#pragma mark - Private Method

- (void)_startRefresh
{
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
