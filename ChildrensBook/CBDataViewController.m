//
//  CBDataViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.

//INDIVIDUAL ATTRIBUTES FOR ATTRIBUTED STRING
static NSString *FONT_NAME = @"Helvetica-Bold";
static CGFloat FONT_SIZE = 50.0f;
//s
#import <QuartzCore/QuartzCore.h>
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
    
    pageView.originalString = self.dataObject[@"text"];
    
    //create default String from attribute dictionary
    NSDictionary  *defaultAttributesDict = @{NSFontAttributeName: [UIFont fontWithName:FONT_NAME size:FONT_SIZE], NSForegroundColorAttributeName: [UIColor blackColor]};
    
    NSAttributedString *defaultString = [[NSAttributedString alloc] initWithString: pageView.originalString attributes:defaultAttributesDict];
    
    pageView.textView.attributedText = defaultString;
    pageView.defaultString = defaultString;
    pageView.defaultAttributesDict = defaultAttributesDict;
    
//    pageView.textView.attributedText = [[NSAttributedString alloc] initWithString: self.dataObject[@"text"]];
//    pageView.defaultString = pageView.textView.attributedText;
    
    //add image
    pageView.imageView.image = [UIImage imageNamed: self.dataObject[@"imageFilename"]];
    pageView.homeButton.layer.cornerRadius = 10;
    pageView.homeButton.clipsToBounds = YES;
    
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
    
    CBPageView *theView = (CBPageView*)self.view;
    theView.audioTextPath = self.dataObject[@"audioFilename"];
    [theView loadSound];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    CBPageView *theView = (CBPageView*)self.view;
    [theView unloadSound];
}

@end
