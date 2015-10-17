//
//  LoginViewController.m
//  Ribbit
//
//  Created by Raphael Melo on 15/10/15.
//  Copyright © 2015 raphaelgmelo. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (IBAction)login:(id)sender {
    
    
    NSString *username = [self.usernameField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [self.passwordField.text
                          stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0 ){
        
        UIAlertController * alertController = [UIAlertController
                                               alertControllerWithTitle:@"Oops!"
                                               message:@"Make sure you enter a username and password!"
                                               preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alertController addAction:ok]; // add action to uialertcontroller
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    else{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error){
                
                UIAlertController * alertController = [UIAlertController
                                                       alertControllerWithTitle:@"Sorry!"
                                                       message: [error.userInfo objectForKey:@"error"]
                                                       preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Do some thing here
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                [alertController addAction:ok]; // add action to uialertcontroller
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
}








@end
