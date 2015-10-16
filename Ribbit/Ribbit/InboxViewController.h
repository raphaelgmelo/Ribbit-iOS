//
//  InboxTableViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InboxViewController : UITableViewController

@property (nonatomic, strong) NSArray *messages;

- (IBAction)logout:(id)sender;

@end
