//
//  EditFriendsTableViewController.m
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import "EditFriendsViewController.h"


@interface EditFriendsViewController ()

@end

@implementation EditFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        if (error){
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else{
            self.allUsers = objects;
            
            // Update table view
            [self.tableView reloadData];
        }
        
        
    }];
    
    
    self.currentUser = [PFUser currentUser];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    
    if ([self isFriend:user]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    PFUser *user = [self.allUsers objectAtIndex:indexPath.row];
    PFRelation *friendsRelation = [self.currentUser relationForKey:@"friendsRelation"];

    if ([self isFriend:user]) {
        
        // Remove the checkmarks
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        // Remove from the array of friends
        for (PFUser *friend in self.friends){
            if ([friend.objectId isEqualToString:user.objectId]) {
                [self.friends removeObject:friend];
                break;
            }
        }
        
        // Remove the user from the backend
        [friendsRelation removeObject:user];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

        [self.friends addObject:user];
        [friendsRelation addObject:user];
    }
    
    // Save friend
    [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


#pragma mark - Helper methods

-(BOOL) isFriend: (PFUser *) user{
    
    for (PFUser *friend in self.friends){
        if ([friend.objectId isEqualToString:user.objectId]) {
            return YES;
        }
    }
    return NO;
    
}

@end
