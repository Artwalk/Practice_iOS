//
//  AlbumTableViewCell.h
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *laberAlbumTitle;
@property (weak, nonatomic) IBOutlet UILabel *laberAlbumSummary;
@property (weak, nonatomic) IBOutlet UILabel *laberPrice;

@end
