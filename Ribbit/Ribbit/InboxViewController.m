//
//  InboxTableViewController.m
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import "InboxViewController.h"
#import "ImageViewController.h"

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
     
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        else{
            //found messages
            self.messages = objects;
            [self.tableView reloadData];
            NSLog(@"Retrieved %d messages", [self.messages count]);
        }
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (IBAction)logout:(id)sender {
    
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"showLogin"] ) {
        //Hide tabs
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    } else if ([segue.identifier isEqualToString:@"showImage"] ) {
        //Hide tabs
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImageViewController *imageViewController = (ImageViewController *)segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]){
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else{
        cell.imageView.image = [UIImage imageNamed:@"icon_video"];
    }
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]){
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else{
        // file type is video
        PFFile *videoFile = [self.selectedMessage objectForKey:@"file"];
        NSURL *fileUrl = [NSURL URLWithString:videoFile.url];
        self.moviePlayer.contentURL = fileUrl;
        [self.moviePlayer prepareToPlay];
        
        [self.moviePlayer thumbnailImageAtTime:0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        // add it to the view controller so we can see it
        [self.view addSubview:self.moviePlayer.view];
        [self.moviePlayer setFullscreen:YES animated:YES];
        
        [self.moviePlayer play];
    }
    
    //Delete the message
    NSMutableArray *recipientIds = [NSMutableArray arrayWithArray:[self.selectedMessage objectForKey:@"recipientIds"]];
    NSLog(@"Recipients: %@", recipientIds);
    
    if ([recipientIds count] == 1) {
        //delete
        [self.selectedMessage deleteInBackground];
    }
    else{
        //remove the recipient
        [recipientIds removeObject:[[PFUser currentUser] objectId]];
        [self.selectedMessage setObject:recipientIds forKey:@"recipientIds"];
        [self.selectedMessage saveInBackground];
    }
}


@end
