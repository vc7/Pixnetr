//
//  PXProfileTableViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/07/30.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXProfileTableViewController.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface PXProfileTableViewController ()

@end

@implementation PXProfileTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.title = @"Profile";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"tab_profile.png"] tag:self.tabBarItem.tag];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ( ! [PXKUser currentUser]) {
        cell.textLabel.text = @"Facebook 登入";
        
        UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginButton setTitle:@"登入" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(_logIn) forControlEvents:UIControlEventTouchUpInside];
        loginButton.frame = (CGRect){ 0, 0, 50, 35 };
        
        cell.accessoryView = loginButton;
        
    } else {
        cell.textLabel.text = @"已經登入 Facebook";
        
        UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [logoutButton setTitle:@"登出" forState:UIControlStateNormal];
        [logoutButton addTarget:self action:@selector(_logOut) forControlEvents:UIControlEventTouchUpInside];
        logoutButton.frame = (CGRect){ 0, 0, 50, 35 };
        
        cell.accessoryView = logoutButton;
    }
    
    
    return cell;
}

#pragma mark - Button Actions

- (void)_logIn
{
    [PXKUser logInWithResultBlock:^(PXKUser *user, NSError *error) {
        if ( ! error) {
            [self.tableView reloadData];
        }
    }];
}

- (void)_logOut
{
    [PXKUser logOut];
    [self.tableView reloadData];
}

@end
