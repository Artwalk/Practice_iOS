//
//  ARTDetailViewController.h
//  1.27.UISplitViewController
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARTDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
