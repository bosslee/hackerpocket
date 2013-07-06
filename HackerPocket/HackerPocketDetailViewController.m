//
//  HackerPocketDetailViewController.m
//  HackerPocket
//
//  Created by Bryan Lee on 6/7/13.
//  Copyright (c) 2013 bybosslee. All rights reserved.
//

#import "HackerPocketDetailViewController.h"
#import <Social/Social.h>

@interface HackerPocketDetailViewController ()
@end

@implementation HackerPocketDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    NSURL *myurl = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myurl];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitterShare:(UIBarButtonItem *)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        
//        NSString *by = @"By: ";
//        NSString *name = [[feeds objectAtIndex:indexPath.row] objectForKey: @"username"];
//        cell.detailTextLabel.text = [by stringByAppendingString:name];
        
        NSString *by = _titleForTweet;
        [tweetSheet setInitialText:[by stringByAppendingString:@" (via hackerpocket)"]];
        [tweetSheet addURL:[NSURL URLWithString:_url]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
}
@end
