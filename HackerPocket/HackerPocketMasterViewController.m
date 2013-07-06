//
//  HackerPocketMasterViewController.m
//  HackerPocket
//
//  Created by Bryan Lee on 6/7/13.
//  Copyright (c) 2013 bybosslee. All rights reserved.
//

#import "HackerPocketMasterViewController.h"

#import "HackerPocketDetailViewController.h"

@interface HackerPocketMasterViewController () {
    NSMutableArray *feeds; //contain list of feeds
    NSXMLParser *parser;
    NSMutableDictionary *item; //details of feeds so to store items into it

    NSString *element; //element will help us to control with element is currently parsing the NSXMLParser object.
    
    NSMutableString *title; //title of feeds
    NSMutableString *link; //link of feeds
    NSMutableString *num_comments;
    NSMutableString *points;
    NSMutableString *username;
    
}
@end

@implementation HackerPocketMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //add details
    feeds = [[NSMutableArray alloc] init];
    NSURL *url  = [NSURL URLWithString:@"http://hnsearch.com/bigrss"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString *by = @"By: ";
    NSString *name = [[feeds objectAtIndex:indexPath.row] objectForKey: @"username"];
    cell.detailTextLabel.text = [by stringByAppendingString:name];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        NSString *tweet = [feeds[indexPath.row] objectForKey: @"title"];
        [[segue destinationViewController] setTitleForTweet:tweet];
        
    }
}

#pragma mark - parsing the delegate

//Whenever the parser finds a new element, it calls the didStartElement method from its delegate. 

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    NSLog(@"This is the element %@", element);
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        NSLog(@"What is this item %@",item);
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        num_comments = [[NSMutableString alloc] init];
        points = [[NSMutableString alloc] init];
        username = [[NSMutableString alloc] init];
    }
        
}

//parser calls its delegate every time new characters are found
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
        
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"num_comments"]) {
        [num_comments appendString:string];
    } else if ([element isEqualToString:@"points"]) {
        [points appendString:string];
    } else if ([element isEqualToString:@"username"]) {
        [username appendString:string];
    }
}

//When the parser encounters the end of an element, it calls the didEndElement method.

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:num_comments forKey:@"num_comments"];
        [item setObject:points forKey:@"points"];
        [item setObject:username forKey:@"username"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    
}

@end
