//
//  HackerPocketDetailViewController.m
//  HackerPocket
//
//  Created by Bryan Lee on 6/7/13.
//  Copyright (c) 2013 bybosslee. All rights reserved.
//

#import "HackerPocketDetailViewController.h"

@interface HackerPocketDetailViewController ()
- (void)configureView;
@end

@implementation HackerPocketDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
