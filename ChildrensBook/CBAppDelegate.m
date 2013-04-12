//
//  CBAppDelegate.m
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import "CBAppDelegate.h"
#import "CBRootViewController.h"
#import "CBModelController.h"

@implementation CBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    CBRootViewController *rootVC = (CBRootViewController*)self.window.rootViewController;
    
    [[NSUserDefaults standardUserDefaults] setInteger: rootVC.currentPageIndex forKey: @"kCurrentPage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"NSUserDefaults: %@", [[NSUserDefaults standardUserDefaults]
                                  dictionaryRepresentation]);
    
    NSLog(@"Application will resign on bookmarked page %d", rootVC.currentPageIndex);
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    CBRootViewController *rootVC = (CBRootViewController*)self.window.rootViewController;
    
    NSUInteger currentPage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"kCurrentPage"] intValue];
    
    UIViewController *bookmarkedVC = [rootVC.modelController viewControllerAtIndex:currentPage storyboard:rootVC.storyboard];
    
    [rootVC.pageViewController setViewControllers: @[bookmarkedVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    NSLog(@"Application did become active on bookmarked page %d", currentPage);

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
