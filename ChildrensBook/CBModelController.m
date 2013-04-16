//
//  CBModelController.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import "CBModelController.h"
#import "CBDataViewController.h"
#import "CBHomePageViewController.h"
#import "CBCreditsViewController.h"
#import "CBTableOfContentsViewController.h"
#import "CBEndingViewController.h"

@interface CBModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation CBModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"StoryData" ofType:@"plist"];
        _pageData = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count] + 3)) {
        return nil;
    }
    
    if (index==0) {
        CBHomePageViewController *homePageViewController = [storyboard instantiateViewControllerWithIdentifier:@"CBHomePageViewController"];
        return homePageViewController;
    }
    
    
    if (index==1) {
        CBTableOfContentsViewController *tableOfContentsViewController = [storyboard instantiateViewControllerWithIdentifier:@"CBTableOfContentsViewController"];
        return tableOfContentsViewController;
    }
    
    if (index==[self.pageData count]+2) {
        CBEndingViewController *endingViewController = [storyboard instantiateViewControllerWithIdentifier:@"CBEndingViewController"];
        return endingViewController;
    }
    
    // ELSE: Create a new view controller and pass suitable data.
    CBDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"CBDataViewController"];
    NSLog(@"index in viewController at index method: %d", index);
    
//    CBRootViewController *rootVC = (CBRootViewController*)self.pageViewController.parentViewController;
//    rootVC.delegate = dataViewController;
    
    dataViewController.dataObject = self.pageData[index-2];
    dataViewController.modelController = self;
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController
{
    
    if ( [viewController isKindOfClass:[CBHomePageViewController class]] ) return 0;
    if ( [viewController isKindOfClass:[CBTableOfContentsViewController class]] ) return 1;
    if ( [viewController isKindOfClass:[CBEndingViewController class]] ) return 7;
    
    else return [self.pageData indexOfObject: ((CBDataViewController*)viewController).dataObject ] + 2;
    
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    NSLog(@"Index before: %d", index);
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController: viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    NSLog(@"Index after: %d", index);
    if (index == [self.pageData count]+3) {
        NSLog(@"We're in the nil");
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
