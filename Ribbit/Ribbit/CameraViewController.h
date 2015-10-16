//
//  CameraViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, strong) UIImagePickerController * imagePicker;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, strong) NSString * videoFilePath;

@end
