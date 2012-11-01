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
@synthesize searchDisplayController;
@synthesize searchBar;
@synthesize friends;
@synthesize searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.FriendsListTableView.scrollEnabled = YES;
    NSArray *tmp = [[NSArray alloc] initWithObjects:@"张三", @"李四", @"东东", @"小林", @"陆路", @"甜甜", @"daisy", @"ruoyi", @"yanyu", nil];
    self.friends = tmp;
    [self.FriendsListTableView reloadData];
}


- (void)viewDidUnload
{
    [self setFriendsListTableView:nil];
    [self setSearchDisplayController:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark table view delegate method

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 0;
    if([tableView isEqual:self.searchDisplayController.searchResultsTableView])
        rows = [self.searchResults count];
    else
        rows = [self.friends count];
    return rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if([tableView isEqual:self.searchDisplayController.searchResultsTableView])
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [self.friends objectAtIndex:indexPath.row];
    return cell;
}

-(void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchText];
    self.searchResults = [self.friends filteredArrayUsingPredicate:predicate];
}

#pragma mark -
#pragma mark UISearchDisplayController delegate methods

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

@end
