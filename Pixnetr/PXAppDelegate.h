//
//  PXAppDelegate.h
//  Pixnetr
//
//  Created by vincent on 2014/07/29.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (PXAppDelegate *)sharedAppDelegate;

@end
