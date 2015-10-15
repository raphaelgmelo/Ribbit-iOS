//
//  FriendsViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@interface FriendsViewController : UITableViewController

@property (nonatomic, strong) PFRelation *friendsRelation;
@property (nonatomic, strong) NSArray *friends;


@end
