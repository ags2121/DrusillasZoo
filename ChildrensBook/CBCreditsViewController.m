//
//  CBCreditsViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/6/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import "CBCreditsViewController.h"
#import "CBCreditsTableViewCell.h"

@interface CBCreditsViewController ()

@property (strong, nonatomic) NSArray* credits; 

@end

@implementation CBCreditsViewController 

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CreditsList" ofType:@"plist"];
	_credits = [[NSArray alloc] initWithContentsOfFile:path];
    
    //set optionsTableView delegate and datasource
    [self.creditsTable setDataSource:self];
    [self.creditsTable setDelegate:self];
    [self.creditsTable reloadData];
    
//    self.contentSizeForViewInPopover = CGSizeMake(108,400);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.credits.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    //IMPORTANT: Change if there are multiple attributions per position, i.e., more than one author
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.credits[section][@"position"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CBCreditsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"creditsTableViewCell" forIndexPath:indexPath];
    cell.collaborator.text = self.credits[indexPath.section][@"name"];
    
    return cell;
}


@end
