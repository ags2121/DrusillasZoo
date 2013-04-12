//
//  CBCreditsViewController.h
//  ChildrensBook
//
//  Created by Alex Silva on 4/6/13.
//  Copyright (c) 2013 Alex Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBCreditsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *creditsTable;
@end
