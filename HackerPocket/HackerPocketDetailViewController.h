//
//  HackerPocketDetailViewController.h
//  HackerPocket
//
//  Created by Bryan Lee on 6/7/13.
//  Copyright (c) 2013 bybosslee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HackerPocketDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
