//
//  ViewController.m
//  SmartWallet
//
//  Created by itkmitl on 7/11/56 BE.
//  Copyright (c) 2556 itkmitl. All rights reserved.
//

#import "ViewController.h"
#import "PromotionTableViewController.h"
#import "AFJSONRequestOperation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:@"http://localhost:8082/getPromotions"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.promotionsArray = (NSArray *) JSON;
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: \n%@", error);
    }];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/login"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON from web server\n %@", [JSON valueForKey:@"email"]);
        NSArray *jsonArray = (NSArray *) JSON;
        for (NSInteger i = 0; i < [jsonArray count]; i++) {
            NSDictionary *jsonDict = (NSDictionary *) [jsonArray objectAtIndex:i];
            if ([self.usernameTextField.text isEqualToString:[jsonDict objectForKey:@"email"]] || [self.usernameTextField.text isEqualToString:[jsonDict objectForKey:@"_id"]]) {
                if ([self.passwordTextField.text isEqualToString:[jsonDict objectForKey:@"password"]]) {
                    self.loginStatusLabel.text = @"Login Successful";
                    self.userDict = jsonDict;
                    [self performSegueWithIdentifier:@"loginSuccess" sender:sender];
                    break;
                }
                else {
                    self.loginStatusLabel.text = @"email or password is wrong.";
                }
            }
            else {
                self.loginStatusLabel.text = @"email or password is wrong.";
            }
        }
        NSDictionary *jsonDict = (NSDictionary *) [jsonArray objectAtIndex:0];
        NSLog(@"email: %@\npassword: %@", [jsonDict objectForKey:@"email"], [jsonDict objectForKey:@"password"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: \n%@", error);
    }];
    
    [operation start];
}

- (IBAction)backgroundClicked:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)usernameTextFieldKeyBoardDown:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)passwordTextFieldKeyBoardDown:(id)sender {
    [sender resignFirstResponder];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loginSuccess"]) {
        UITabBarController *tabBarController = (UITabBarController *) segue.destinationViewController;
        UINavigationController *navigationController = (UINavigationController *) [tabBarController.viewControllers objectAtIndex:0];
        PromotionTableViewController *promotionTableViewPage = (PromotionTableViewController *) [navigationController topViewController];
        promotionTableViewPage.userDict = self.userDict;
        promotionTableViewPage.promotionsArray = self.promotionsArray;
    }
}

- (IBAction)registerPressed:(id)sender {
}
@end
