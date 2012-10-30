//
//  FriendsListViewController.m
//  Timeline
//
//  Created by 04 developer on 12-10-24.
//  Copyright (c) 2012年 Sun Yat-sen University. All rights reserved.
//

#import "FriendsListViewController.h"

@implementation FriendsListViewController
@synthesize FriendsListTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setFriendsListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
