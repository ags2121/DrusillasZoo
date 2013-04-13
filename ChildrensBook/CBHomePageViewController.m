//
//  CBHomePageViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/6/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "CBHomePageViewController.h"
#import "CBCreditsViewController.h"

@interface CBHomePageViewController ()

@property (strong, nonatomic) UIPopoverController *popover;
@property SystemSoundID soundID;

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
	[self loadSound:@"cover"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)creditsButtonPressed:(id)sender {
    
    [self playSound];
    
    UIButton *button = (UIButton*)sender;
    
    CBCreditsViewController *creditsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CBCreditsViewController"];
    
    _popover = [[UIPopoverController alloc] initWithContentViewController:creditsViewController];
    
    [self.popover presentPopoverFromRect:CGRectMake(button.frame.size.width / 2, button.frame.size.height / 2, 1, 1) inView:button permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
    
}


-(void)loadSound:(NSString*)audioTextPath
{
    NSString *audioPath = [[NSBundle mainBundle]
                           pathForResource:audioTextPath ofType:@"aiff"];
    NSURL *audioURL = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
                                     audioURL, &_soundID);
}

-(void)unloadSound
{
    AudioServicesDisposeSystemSoundID(_soundID);
    NSLog(@"Disposing sound");
}

-(void)playSound
{
    AudioServicesPlaySystemSound(_soundID);
}
@end
