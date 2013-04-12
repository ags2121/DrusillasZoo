//
//  CBHomePageViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/6/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import "CBHomePageViewController.h"
#import "CBCreditsViewController.h"

@interface CBHomePageViewController ()

@property (strong, nonatomic) UIPopoverController *popover;

@end

@implementation CBHomePageViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)creditsButtonPressed:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    
    CBCreditsViewController *creditsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CBCreditsViewController"];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:creditsViewController];
    
    [self.popover presentPopoverFromRect:CGRectMake(button.frame.size.width / 2, button.frame.size.height / 2, 1, 1) inView:button permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
    
}
@end
