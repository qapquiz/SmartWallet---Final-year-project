//
//  PromotionDetailViewController.h
//  SmartWallet
//
//  Created by itkmitl on 7/17/56 BE.
//  Copyright (c) 2556 itkmitl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionDetailViewController : UIViewController
@property NSDictionary *promotionDictDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeDetailLabel;

@end
