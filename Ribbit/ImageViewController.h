//
//  ImageViewController.h
//  Ribbit
//
//  Created by Raphael Melo on 16/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController


@property (nonatomic,strong) PFObject *message;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void) timeout;

@end
