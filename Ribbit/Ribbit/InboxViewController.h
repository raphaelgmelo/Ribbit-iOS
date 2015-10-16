//
//  InboxTableViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface InboxViewController : UITableViewController

@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) PFObject *selectedMessage;

- (IBAction)logout:(id)sender;

@end
