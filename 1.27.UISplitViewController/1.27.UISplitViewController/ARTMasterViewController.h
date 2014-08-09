//
//  ARTMasterViewController.h
//  1.27.UISplitViewController
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARTDetailViewController;

@interface ARTMasterViewController : UITableViewController

@property (strong, nonatomic) ARTDetailViewController *detailViewController;

@end
