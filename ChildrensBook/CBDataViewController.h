//
//  CBDataViewController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/4/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBRootViewController.h"
#import "CBModelController.h"
#import "CBPageView.h"

@class CBDataViewController;

@interface CBDataViewController : UIViewController <UIGestureRecognizerDelegate, CBPageViewDelegate>

@property (strong, nonatomic) NSDictionary *dataObject;
@property (strong, nonatomic) CBModelController *modelController;

@end
