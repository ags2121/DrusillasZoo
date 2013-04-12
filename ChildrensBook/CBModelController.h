//
//  CBModelController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBDataViewController;

@interface CBModelController : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;

@end
