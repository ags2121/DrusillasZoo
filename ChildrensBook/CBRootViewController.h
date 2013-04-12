//
//  CBRootViewController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBModelController.h"

@interface CBRootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (readonly, strong, nonatomic) CBModelController *modelController;
@property NSUInteger currentPageIndex;

@end
