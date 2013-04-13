//
//  CBEndingViewController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/8/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CBEndingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *pageText;
@property (weak, nonatomic) IBOutlet UIImageView *pageImage;

@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonMiddle;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;
@property (weak, nonatomic) IBOutlet UIButton *theEndButton;

@property (strong, nonatomic) NSString *audioTextPath;
@property SystemSoundID soundID;

- (IBAction)hitTheEndButton:(id)sender;
- (IBAction)hitButtonLeft:(id)sender;
- (IBAction)hitButtonMiddle:(id)sender;
- (IBAction)hitButtonRight:(id)sender;

@end
