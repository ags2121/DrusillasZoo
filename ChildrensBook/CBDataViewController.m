//
//  CBDataViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.

//INDIVIDUAL ATTRIBUTES FOR ATTRIBUTED STRING
static NSString *FONT_NAME = @"ChalkboardSE-Regular";
static CGFloat FONT_SIZE = 50.0f;
//TODO: line spacing attribute

#import <QuartzCore/QuartzCore.h>
#import "CBHomePageViewController.h"
#import "CBDataViewController.h"
#import "CBPageView.h"

@interface CBDataViewController ()

@end

@implementation CBDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //create view
    CBPageView *pageView = [[CBPageView alloc] initWithFrame:self.view.bounds];
    //add text
    
    //make CDDataViewController the CBPageView's delegate
    pageView.delegate = self;
    
    pageView.originalString = self.dataObject[@"text"];
    
    //create default String from attribute dictionary
    NSDictionary  *defaultAttributesDict = @{NSFontAttributeName: [UIFont fontWithName:FONT_NAME size:FONT_SIZE], NSForegroundColorAttributeName: [UIColor blackColor]};
    
    NSAttributedString *defaultString = [[NSAttributedString alloc] initWithString: pageView.originalString attributes:defaultAttributesDict];
    
    pageView.textView.attributedText = defaultString;
    pageView.defaultString = defaultString;
    pageView.defaultAttributesDict = defaultAttributesDict;
    
    pageView.timeCodes = self.dataObject[@"timeCodes"];
    pageView.audioTextPath = self.dataObject[@"audioFilename"];
    [pageView loadSound];
    
    //add image
    pageView.imageView.image = [UIImage imageNamed: self.dataObject[@"imageFilename"]];
    pageView.homeButton.layer.cornerRadius = 10;
    pageView.homeButton.clipsToBounds = YES;
    pageView.readToMeButton.layer.cornerRadius = 10;
    pageView.readToMeButton.clipsToBounds = YES;
    
    //make pageView the VC's view
    self.view = pageView;

    //pass along text as words in an array, for processing
    pageView.wordArray = [self.dataObject[@"text"] componentsSeparatedByString:@" "];    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CBPageView *theView = (CBPageView*)self.view;
    [theView unloadSound];
}

-(void)jumpToHomePage{
    
    // Grab the viewControllers at position 4 & 5 - note, your model is responsible for providing these.
    // Technically, you could have them pre-made and passed in as an array containing the two items...
    
    CBHomePageViewController *homePageVC = (CBHomePageViewController*)[self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    
    //  Set up the array that holds the VCs
    NSArray *viewControllersToJumpTo = @[homePageVC];
    
    [self.modelController.pageViewController setViewControllers:viewControllersToJumpTo direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:NULL];
    
}

@end
