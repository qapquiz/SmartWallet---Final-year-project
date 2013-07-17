//
//  PromotionDetailViewController.m
//  SmartWallet
//
//  Created by itkmitl on 7/17/56 BE.
//  Copyright (c) 2556 itkmitl. All rights reserved.
//

#import "PromotionDetailViewController.h"

@interface PromotionDetailViewController ()

@end

@implementation PromotionDetailViewController

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
    NSLog(@"promotionDeatilDict: \n%@", self.promotionDictDetail);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
