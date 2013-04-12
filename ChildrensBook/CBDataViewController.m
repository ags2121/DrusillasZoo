//
//  CBDataViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
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
    pageView.textView.attributedText = [[NSAttributedString alloc] initWithString: self.dataObject[@"text"]];
    pageView.defaultString = pageView.textView.attributedText;
    //add image
    pageView.imageView.image = [UIImage imageNamed: self.dataObject[@"imageFilename"]];
    pageView.homeButton.layer.cornerRadius = 10;
    pageView.homeButton.clipsToBounds = YES;
    

    
    //make pageView the VC's view
    self.view = pageView;

    //pass along text as words in an array, for processing
    pageView.wordArray = [self.dataObject[@"text"] componentsSeparatedByString:@" "];
    
    
    NSDictionary * normalAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    pageView.attributedStrings2 = [[NSMutableArray alloc] initWithCapacity:1];
    
    for( NSString *normalString in pageView.wordArray){
        [ pageView.attributedStrings2 addObject: [[NSMutableAttributedString alloc] initWithString:normalString attributes:normalAttributes] ];
    }
    
    
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
