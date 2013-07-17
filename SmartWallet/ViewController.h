//
//  ViewController.h
//  SmartWallet
//
//  Created by itkmitl on 7/11/56 BE.
//  Copyright (c) 2556 itkmitl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginStatusLabel;
@property NSDictionary *userDict;
@property NSArray *promotionsArray;
- (IBAction)loginPressed:(id)sender;
- (IBAction)backgroundClicked:(id)sender;
- (IBAction)usernameTextFieldKeyBoardDown:(id)sender;
- (IBAction)passwordTextFieldKeyBoardDown:(id)sender;


@end
