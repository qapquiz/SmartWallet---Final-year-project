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
    /*NSURL *url = [NSURL URLWithString:@"http://localhost:8082/getPromotions"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        self.promotionsArray = (NSArray *) JSON;
        NSLog(@"%@", self.promotionsArray);
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: \n%@", error);
    }];
    [operation start];*/
}

-(void) viewWillAppear:(BOOL)animated {
    /*NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userDict = [defaults objectForKey:@"userDict"];
    if (self.userDict) {
        NSLog(@"%@", self.userDict);
        [self performSegueWithIdentifier:@"loginSuccess" sender:nil];
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    //when user click login button do this thing!
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:8082/login"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    //open connection to mongodb
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON from web server\n %@", [JSON valueForKey:@"email"]);
        //get JSON Array from users collection
        NSArray *jsonArray = (NSArray *) JSON;
        
        //for loop to get each user to check
        BOOL checkLogin;
        for (NSInteger i = 0; i < [jsonArray count]; i++) {
            NSDictionary *jsonDict = (NSDictionary *) [jsonArray objectAtIndex:i];
            
            //check username or email
            if ([self.usernameTextField.text isEqualToString:[jsonDict objectForKey:@"email"]] || [self.usernameTextField.text isEqualToString:[jsonDict objectForKey:@"_id"]]) {
                
                //check password
                if ([self.passwordTextField.text isEqualToString:[jsonDict objectForKey:@"password"]]) {
                    checkLogin = YES;
                    self.loginStatusLabel.text = @"Login Successful";
                    self.userDict = jsonDict;
                    
                    //save user data to NSUserDefaults
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:self.userDict forKey:@"userDict"];
                    NSLog(@"Data saved into NSUserDefaults");
                    //end save user data to NSUserDefaults
                    
                    //modal to tableviewController -> invoke prepareForSegue method
                    [self performSegueWithIdentifier:@"loginSuccess" sender:sender];
                    break;
                }
                else {
                    checkLogin = NO;
                    self.loginStatusLabel.text = @"email or password is wrong.";
                }
            }
            else {
                checkLogin = NO;
                self.loginStatusLabel.text = @"email or password is wrong.";
            }
        }
        if (checkLogin == NO) {
            [self showLoginFailedAlert];
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
        //promotionTableViewPage.promotionsArray = self.promotionsArray;
    }
}

- (IBAction)registerPressed:(id)sender {
}

- (void)showLoginFailedAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"email or password is wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}
@end
