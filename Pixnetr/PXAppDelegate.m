//
//  PXAppDelegate.m
//  Pixnetr
//
//  Created by vincent on 2014/07/29.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <PXKService.h>

#import "PXAppDelegate.h"
#import "PXDefines.h"

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
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)_bootstrapServices
{
    [PXKService setParseApplicationId:kPXParseApplicationID clientKey:kPXParseClientKey];
    [PXKService setPixnetConsumerKey:kPXPixnetConsumerKey consumerSecret:kPXPixnetConsumerSecret callbackURL:@"http://devtool.pixnet.pro/index/cb"];
}

@end
