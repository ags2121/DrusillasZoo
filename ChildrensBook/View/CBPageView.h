//
//  CBPageView.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface CBPageView : UIView

@property (strong, nonatomic) NSArray *wordArray;
@property (strong, nonatomic) NSAttributedString *defaultString;
@property (strong, nonatomic) NSString *audioTextPath;
@property SystemSoundID soundID;

@property (strong, nonatomic) NSMutableArray *attributedStrings2;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *readToMeButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)buttonPressed:(id)sender;
-(void)loadSound;
-(void)unloadSound;

@end
