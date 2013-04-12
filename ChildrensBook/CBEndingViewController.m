//
//  CBEndingViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/8/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

static NSTimeInterval leftAudioTime = 3.0;

#import "CBEndingViewController.h"

@interface CBEndingViewController ()

@property (strong, nonatomic) NSTimer *btnRightTimer;

@end

@implementation CBEndingViewController

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


- (IBAction)hitButtonLeft:(id)sender {
}

- (IBAction)hitButtonMiddle:(id)sender {
}

- (IBAction)hitButtonRight:(id)sender {
    
    [self.btnRightTimer invalidate];
    
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_rightHighlight"];
    
    self.btnRightTimer = [NSTimer scheduledTimerWithTimeInterval: leftAudioTime target:self selector:@selector(changeBackToDefaultImage:) userInfo:NULL repeats: NO];
    
    //TODO: play sound
}

-(void)changeBackToDefaultImage:(NSTimer*)aTimer
{
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_Normal"];
}

@end
