//
//  CBEndingViewController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/8/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

static NSTimeInterval leftAudioTime = 2.0;
static NSTimeInterval midAudioTime = 2.0;
static NSTimeInterval rightAudioTime = 2.0;

#import "CBEndingViewController.h"

@interface CBEndingViewController ()

@property (strong, nonatomic) NSTimer *btnLeftTimer;
@property (strong, nonatomic) NSTimer *btnMiddleTimer;
@property (strong, nonatomic) NSTimer *btnRightTimer;
@property (strong, nonatomic) NSTimer *endTimer;

@property(strong, nonatomic) NSArray *theEndTimeCodeArray;
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
    _theEndTimeCodeArray = @[@1.29, @1.76, @2.33, @3.2];
    
    [self loadSound:@"bye"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)hitTheEndButton:(id)sender
{
    self.buttonRight.enabled = NO;
    self.buttonMiddle.enabled = NO;
    self.buttonLeft.enabled = NO;
    
    [self playSound];

    self.btnLeftTimer = [NSTimer scheduledTimerWithTimeInterval: [self.theEndTimeCodeArray[0] doubleValue] target:self selector:@selector(changeBackgroundImage:) userInfo:@"CBEndingImg_leftHighlight" repeats: NO];
    self.btnMiddleTimer = [NSTimer scheduledTimerWithTimeInterval: [self.theEndTimeCodeArray[1] doubleValue] target:self selector:@selector(changeBackgroundImage:) userInfo:@"CBEndingImg_middleHighlight" repeats: NO];
    self.btnRightTimer = [NSTimer scheduledTimerWithTimeInterval: [self.theEndTimeCodeArray[2] doubleValue] target:self selector:@selector(changeBackgroundImage:) userInfo:@"CBEndingImg_rightHighlight" repeats: NO];
    self.endTimer = [NSTimer scheduledTimerWithTimeInterval: [self.theEndTimeCodeArray[3] doubleValue] target:self selector:@selector(changeBackToDefaultImage:) userInfo:NULL repeats: NO];
    
}

- (IBAction)hitButtonLeft:(id)sender
{
    
    self.buttonRight.enabled = NO;
    self.buttonMiddle.enabled = NO;
    
    [self.btnLeftTimer invalidate];
    
    //TODO: play sound
    
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_leftHighlight"];
    
    self.btnLeftTimer = [NSTimer scheduledTimerWithTimeInterval: leftAudioTime target:self selector:@selector(changeBackToDefaultImage:) userInfo:NULL repeats: NO];
}

- (IBAction)hitButtonMiddle:(id)sender
{
    
    self.buttonLeft.enabled = NO;
    self.buttonRight.enabled = NO;
    
    [self.btnMiddleTimer invalidate];
    
    //TODO: play sound
    
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_middleHighlight"];
    
    self.btnMiddleTimer = [NSTimer scheduledTimerWithTimeInterval: midAudioTime target:self selector:@selector(changeBackToDefaultImage:) userInfo:NULL repeats: NO];
}

- (IBAction)hitButtonRight:(id)sender
{
    self.buttonLeft.enabled = NO;
    self.buttonMiddle.enabled = NO;
    
    [self.btnRightTimer invalidate];
    
    //TODO: play sound
    
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_rightHighlight"];
    
    self.btnRightTimer = [NSTimer scheduledTimerWithTimeInterval: rightAudioTime target:self selector:@selector(changeBackToDefaultImage:) userInfo:NULL repeats: NO];
}

-(void)changeBackToDefaultImage:(NSTimer*)aTimer
{
    self.pageImage.image = [UIImage imageNamed: @"CBEndingImg_Normal"];
    self.buttonLeft.enabled = YES;
    self.buttonMiddle.enabled = YES;
    self.buttonRight.enabled = YES;
}

-(void)changeBackgroundImage:(NSTimer*)aTimer
{
    NSString *imageName = aTimer.userInfo;
    self.pageImage.image = [UIImage imageNamed: imageName];
}

#pragma - Audio methods

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
