//
//  CBRootViewController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBModelController.h"

@protocol CBPanGestureDelegate <NSObject>

- (BOOL)shouldRootViewRespondtoPan:(UIGestureRecognizer*)gesture;

@end

@interface CBRootViewController : UIViewController <UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) CBModelController *modelController;
@property NSUInteger currentPageIndex;

@property (nonatomic, weak) id<CBPanGestureDelegate> delegate;

@end
