//
//  PXPhotoLightBoxViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/08/01.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <SDWebImage/SDWebImageManager.h>

#import "PXPhotoLightBoxViewController.h"
#import "PXPhotoLightBoxMainTableViewCell.h"

static NSString *PhotoCellIdentifier = @"PhotoCellIdentifier";

@interface PXPhotoLightBoxViewController ()

@end

@implementation PXPhotoLightBoxViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        PXPhotoLightBoxMainTableViewCell *cell = (PXPhotoLightBoxMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PhotoCellIdentifier];
        
        if (cell == nil) {
            cell = [[PXPhotoLightBoxMainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PhotoCellIdentifier];
        }
        
        cell.mainImageView.image = nil;
        cell.mainImageView.backgroundColor = [UIColor lightGrayColor];
        cell.photoRatio = [self.photo.photoRatio floatValue];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[PXKURLGenerator generatePhotoImageURLStringWithPhoto:self.photo size:(CGSize){ 640, 640/[self.photo.photoRatio floatValue] }]]
                                                        options:0
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       }
                                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                          if ( ! error) {
                                                              cell.mainImageView.image = image;
                                                          }
                                                      }];
        return cell;

        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhotoCellIdentifier forIndexPath:indexPath];
        
        // Configure the cell...
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return CGRectGetWidth(self.tableView.frame)/[self.photo.photoRatio floatValue];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
}

@end
