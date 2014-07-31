//
//  PXAppDelegate.m
//  Pixnetr
//
//  Created by vincent on 2014/07/29.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <PXKService.h>
#import <CHTCollectionViewWaterfallLayout.h>

#import "PXAppDelegate.h"
#import "PXDefines.h"

#import "PXHotAlbumsViewController.h"
#import "PXSearchTableViewController.h"
#import "PXProfileTableViewController.h"
#import "PXInfoTableViewController.h"

@interface PXAppDelegate ()

@property (strong, nonatomic) UITabBarController *mainTabBarController;

@property (strong, nonatomic) PXHotAlbumsViewController *hotAlbumsViewController;
@property (strong, nonatomic) CHTCollectionViewWaterfallLayout *waterfallLayout;

@end

@implementation PXAppDelegate

+ (PXAppDelegate *)sharedAppDelegate {
	return (PXAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // Bootstrap the Services
    [self _bootstrapServices];
    [self _applyStyleSheet];
    
    self.mainTabBarController.viewControllers = @[self.hotAlbumsViewController,
                                                  [[PXSearchTableViewController alloc] initWithStyle:UITableViewStylePlain],
                                                  [[PXProfileTableViewController alloc] initWithStyle:UITableViewStylePlain],
                                                  [[PXInfoTableViewController alloc] initWithStyle:UITableViewStylePlain]];
    
    self.window.rootViewController = self.mainTabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)_bootstrapServices
{
    [PXKService setParseApplicationId:kPXParseApplicationID clientKey:kPXParseClientKey];
    [PXKService setPixnetConsumerKey:kPXPixnetConsumerKey consumerSecret:kPXPixnetConsumerSecret callbackURL:@"http://devtool.pixnet.pro/index/cb"];
}

#pragma mark - Accessors

- (UITabBarController *)mainTabBarController
{
    if ( ! _mainTabBarController) {
        _mainTabBarController = [[UITabBarController alloc] init];
    }
    
    return _mainTabBarController;
}

- (PXHotAlbumsViewController *)hotAlbumsViewController
{
    if ( ! _hotAlbumsViewController) {
        _hotAlbumsViewController = [[PXHotAlbumsViewController alloc] initWithCollectionViewLayout:self.waterfallLayout];
    }
    
    return _hotAlbumsViewController;
}

- (CHTCollectionViewWaterfallLayout *)waterfallLayout
{
    if ( ! _waterfallLayout) {
        _waterfallLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    }
    
    return _waterfallLayout;
}

#pragma mark - Private Methods

- (void)_bootstrapServices
{
    [PXKService setParseApplicationId:kPXParseApplicationID clientKey:kPXParseClientKey];
    [PXKService setPixnetConsumerKey:kPXPixnetConsumerKey consumerSecret:kPXPixnetConsumerSecret callbackURL:@"http://devtool.pixnet.pro/index/cb"];
}

- (void)_applyStyleSheet
{
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:1 green:0.2 blue:0.3 alpha:1];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UITabBar appearance].tintColor = [UIColor colorWithRed:1 green:0.2 blue:0.3 alpha:1];
}

@end
