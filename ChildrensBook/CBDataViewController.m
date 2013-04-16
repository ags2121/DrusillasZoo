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
    pageView.audioFilename = self.dataObject[@"audioFilename"];
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
    
    //possibly start animation(s)
    if([pageView.audioFilename isEqualToString:@"animals"]){
        NSLog(@"animateBird should get called");
        [pageView animateBird];
    }
    if([pageView.audioFilename isEqualToString:@"snake"]){
        NSLog(@"animateSnake should get called");
        
        CGRect offscreen = CGRectMake(645, -200, 100, 171);
        UIImageView *snake = [[UIImageView alloc] initWithFrame:offscreen];
        snake.image = [UIImage imageNamed:@"snake"];
        snake.userInteractionEnabled = NO;
        
        [self addGestureRecognizers:snake];
        [self.view addSubview:snake];
        [self animateSnake:snake];
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

-(void)animateSnake:(UIImageView*)snake
{
    
    [UIView animateWithDuration:2.3 delay:0.25 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         snake.center = CGPointMake(645, 200);
                     }
                     completion:^(BOOL finished){
                         snake.userInteractionEnabled = YES;
                     }
     ];
}

- (void)addGestureRecognizers:(UIView *)piece
{
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
    [piece addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
    [pinchGesture setDelegate:self];
    [piece addGestureRecognizer:pinchGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [piece addGestureRecognizer:panGesture];
}

- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = gestureRecognizer.view;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Pan piece getting called");
    UIImageView *piece = (UIImageView*)[gestureRecognizer view];
    [[piece superview] bringSubviewToFront:piece];
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
    }
}

/*******************************************************************************
 * @method      rotatePiece:
 * @abstract    <# abstract #>
 * @description rotate the piece by the current rotation
 *              reset the gesture recognizer's rotation to 0 after applying so
 *              the next callback is a delta from the current rotation
 *******************************************************************************/
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

/*******************************************************************************
 * @method      scalePiece
 * @abstract
 * @description Scale the piece by the current scale; reset the gesture recognizer's
 *              rotation to 0 after applying so the next callback is a delta from the current scale
 *******************************************************************************/
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
    }
}


@end
