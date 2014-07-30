//
//  PXInfoTableViewController.m
//  Pixnetr
//
//  Created by vincent on 2014/07/30.
//  Copyright (c) 2014年 Vincent Chen. All rights reserved.
//

#import "PXInfoTableViewController.h"

@interface PXInfoTableViewController ()

@end

@implementation PXInfoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.title = @"Info";
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

@end
