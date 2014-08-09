//
//  testDetailViewController.h
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Album;

@interface testDetailViewController : UITableViewController

@property (strong, nonatomic) Album* detailItem;
@property (weak, nonatomic) IBOutlet UILabel *labelAlbumTitle;
@property (weak, nonatomic) IBOutlet UILabel *LabelArtist;
@property (weak, nonatomic) IBOutlet UILabel *LabelPrice;

@property (weak, nonatomic) IBOutlet UILabel *LabelLocation;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@end
