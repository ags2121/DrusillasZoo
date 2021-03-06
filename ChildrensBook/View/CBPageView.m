//
//  CBPageView.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CBPageView.h"

@interface CBPageView()

@property (strong, nonatomic) NSMutableAttributedString *currentDisplayString;
@property (strong, nonatomic) NSMutableAttributedString *finalString;
@property (strong, nonatomic) NSMutableArray *timers;
@property (strong, nonatomic) NSMutableArray *attrStringArray;
@property NSUInteger index;

@property (strong, nonatomic) UIImageView *snake;

- (void) imageMoved:(id) sender withEvent:(UIEvent *) event;

@end

@implementation CBPageView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CBPageView *CBview = [[[NSBundle mainBundle] loadNibNamed:@"CBPageView" owner:self options:nil] objectAtIndex:0];
        
        //add textView border
        //CBview.textView.layer.borderWidth = 5.0f;
        //CBview.textView.layer.borderColor = [[UIColor magentaColor] CGColor];
        
        /*
         prints font-families
        NSMutableArray *fontNames = [[NSMutableArray alloc] init];
        NSArray *fontFamilyNames = [UIFont familyNames];
        for (NSString *familyName in fontFamilyNames){
            NSLog(@"Font family name = %@", familyName);
            NSArray *names = [UIFont fontNamesForFamilyName:familyName];
             NSLog(@"Font names = %@", fontNames);
            [fontNames addObjectsFromArray:names];
        }
         */
        
        self = CBview;
        
        _timers = [NSMutableArray array];
        _attrStringArray = [[NSMutableArray alloc] initWithCapacity:1];
            
    }
    
    return self;
}

#pragma mark - Read to me methods

- (IBAction)buttonPressed:(id)sender {
    
    NSLog(@"Button pressed");
    
    //RESET ELEMENTS
    //if user presses "read to me!" button while being read to, we need to cancel out the current timers.
    for(NSTimer *timer in self.timers) [timer invalidate];
    [self.timers removeAllObjects];
    
    //unhighlight text
    self.textView.attributedText = self.defaultString;
    
    //remove word elements from attrString array
    [self.attrStringArray removeAllObjects];
    
    //print all elements in array
    for(NSMutableAttributedString *mstr in self.attrStringArray){
        NSLog(@"Array elements %@", mstr.mutableString);
    }
    
    //index counter for timeCode array
    self.index = 0;
    
    //play audio
    [self playSound];
    
    for(NSString *word in self.wordArray){
        
        //retrieve current word to be highlighted
        NSMutableAttributedString *currentHighlightedWord = [[NSMutableAttributedString alloc] initWithString: self.wordArray[_index] attributes:self.defaultAttributesDict];
        
        NSLog(@"Current highlighted word: %@", currentHighlightedWord.mutableString);
        
        NSArray *before;
        NSArray *after;
    
        //CASE: First word
        if (_index == 0) {
            after = [NSArray arrayWithArray: [self.wordArray subarrayWithRange: NSMakeRange(_index+1, self.wordArray.count-(_index+1))]];
            NSMutableAttributedString * tempAfter = [[NSMutableAttributedString alloc] initWithString:[after componentsJoinedByString:@" "] attributes:self.defaultAttributesDict];
            
            //add space to the end of word
            [currentHighlightedWord replaceCharactersInRange:NSMakeRange(currentHighlightedWord.mutableString.length, 0) withString:@" "];
            //add highlight to word
            [currentHighlightedWord addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, currentHighlightedWord.mutableString.length-1)];
            //append the unhighlighted words
            [currentHighlightedWord appendAttributedString:tempAfter];
            [self.attrStringArray addObject:currentHighlightedWord];
            NSLog(@"First index %@", currentHighlightedWord);
        }
        
        //CASE: Last word
        else if(_index == self.wordArray.count-1){
            before = [NSArray arrayWithArray: [self.wordArray subarrayWithRange: NSMakeRange(0, _index)]];
            NSMutableAttributedString * tempBefore = [[NSMutableAttributedString alloc] initWithString:[before componentsJoinedByString:@" "] attributes:self.defaultAttributesDict];
            
            [tempBefore replaceCharactersInRange:NSMakeRange(tempBefore.mutableString.length, 0) withString:@" "];
            
            [currentHighlightedWord addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, currentHighlightedWord.mutableString.length)];
            
            [tempBefore appendAttributedString:currentHighlightedWord];
            [self.attrStringArray addObject:tempBefore];
            NSLog(@"Last index %@", tempBefore);
        }
        
        
        else{
            
            before = [NSArray arrayWithArray: [self.wordArray subarrayWithRange: NSMakeRange(0, _index)]];
            
            NSMutableAttributedString * tempBefore = [[NSMutableAttributedString alloc] initWithString:[before componentsJoinedByString:@" "] attributes:self.defaultAttributesDict];
            
            after = [NSArray arrayWithArray: [self.wordArray subarrayWithRange: NSMakeRange(_index+1, (self.wordArray.count-1)-_index )]];
            NSMutableAttributedString * tempAfter = [[NSMutableAttributedString alloc] initWithString:[after componentsJoinedByString:@" "] attributes:self.defaultAttributesDict];
            
            [tempBefore replaceCharactersInRange:NSMakeRange(tempBefore.mutableString.length, 0) withString:@" "];
            [currentHighlightedWord replaceCharactersInRange:NSMakeRange(currentHighlightedWord.mutableString.length, 0) withString:@" "];
            
            [currentHighlightedWord addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, currentHighlightedWord.mutableString.length-1)];
            
            [tempBefore appendAttributedString:currentHighlightedWord];
            [tempBefore appendAttributedString:tempAfter];
            
            [self.attrStringArray addObject:tempBefore];
                        NSLog(@"%@", tempBefore);
        }

        //create timer
        NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval: [self.timeCodes[_index] doubleValue] target:self selector:@selector(updateTextField:) userInfo: @(_index) repeats: NO];
        
        //add timer to timer array
        [self.timers addObject:aTimer];
        //add timer to runLoop
        [[NSRunLoop mainRunLoop] addTimer: aTimer forMode:NSRunLoopCommonModes];
        
        NSLog(@"timecode: %f", [self.timeCodes[_index] doubleValue]);
        NSLog(@"at index: %d", _index);
        _index++;
        
    }
    
    //reset to default, non-highlighted text
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval: [self.timeCodes[_index] doubleValue] target:self selector:@selector(resetTextField:) userInfo: @(_index) repeats: NO];

    //add last reset timer to timer array
    [self.timers addObject:aTimer];

    [[NSRunLoop mainRunLoop] addTimer: aTimer forMode:NSRunLoopCommonModes];
}

-(void)updateTextField:(NSTimer*)theTimer
{
    
    NSUInteger localIndex = [theTimer.userInfo intValue];
    
    self.textView.attributedText = self.attrStringArray[localIndex];

    [self setNeedsDisplay];
    
}

-(void)resetTextField:(NSTimer*)theTimer
{
    
    self.textView.attributedText = self.defaultString;
    
    [self setNeedsDisplay];
    
}

#pragma mark - Audio methods

-(void)loadSound
{
    NSString *audioPath = [[NSBundle mainBundle]
                            pathForResource:_audioFilename ofType:@"aiff"];
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

- (IBAction)homeButtonPressed:(id)sender
{
    [self.delegate jumpToHomePage];
}

#pragma mark - animation methods
    
-(void)animateBird
{
    NSLog(@"Animating bird");
    CGRect offscreen = CGRectMake(800, 800, 121, 90);
    
    UIImageView *bird = [[UIImageView alloc] initWithFrame:offscreen];
    
    bird.image = [UIImage imageNamed:@"bird"];
    
    [self addSubview:bird];
    
    [UIView animateWithDuration:2.0 delay:0.25 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         bird.center = CGPointMake(384, 800);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:2.0 delay:0.25 options: UIViewAnimationOptionTransitionNone
                                          animations:^{
                                              bird.center = CGPointMake(-100, 800);
                                          }
                                          completion:^(BOOL finished){
                                              NSLog(@"Bird animation complete.");

                                          }
                          
                          ];
                     }
     
     ];
}

-(void)animateSnake
{
    NSLog(@"Animating snake");
    CGRect offscreen = CGRectMake(645, -200, 100, 171);
    
    self.snake = [[UIImageView alloc] initWithFrame:offscreen];
    
    self.snake.image = [UIImage imageNamed:@"snake"];
    
    [self addSubview:self.snake];
    
    [UIView animateWithDuration:2.3 delay:0.25 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.snake.center = CGPointMake(645, 200);
                     }
                     completion:^(BOOL finished){
                      
                                          
                     }
     
     ];
}

@end
