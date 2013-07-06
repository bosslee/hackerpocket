//
//  HackerPocketDetailViewController.h
//  HackerPocket
//
//  Created by Bryan Lee on 6/7/13.
//  Copyright (c) 2013 bybosslee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HackerPocketDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *titleForTweet;
- (IBAction)twitterShare:(UIBarButtonItem *)sender;

@end
