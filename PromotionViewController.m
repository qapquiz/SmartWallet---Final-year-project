//
//  PromotionViewController.m
//  SmartWallet
//
//  Created by itkmitl on 7/15/56 BE.
//  Copyright (c) 2556 itkmitl. All rights reserved.
//

#import "PromotionViewController.h"

@interface PromotionViewController ()

@end

@implementation PromotionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%@", self.userDict);
    self.testDictLabel.text = [self.userDict objectForKey:@"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
