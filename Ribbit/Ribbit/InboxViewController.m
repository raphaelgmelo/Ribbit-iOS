//
//  InboxTableViewController.m
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import "InboxViewController.h"
#import <Parse/Parse.h>

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    
    if (currentUser){
        NSLog(@"Current user: %@", currentUser.username);
    }
    else{
       [self performSegueWithIdentifier:@"showLogin" sender:self];
    }


    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (IBAction)logout:(id)sender {
    
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"showLogin"] ) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    
}

@end
