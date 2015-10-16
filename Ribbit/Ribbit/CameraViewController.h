//
//  CameraViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * videoFilePath;
@property (nonatomic, strong) NSArray * friends;
@property (nonatomic, strong) NSMutableArray * recipients;
@property (nonatomic, strong) PFRelation * friendsRelation;

- (IBAction)cancel:(id)sender;
- (IBAction)send:(id)sender;

@end
