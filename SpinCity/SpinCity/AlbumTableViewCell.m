//
//  AlbumTableViewCell.m
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AlbumTableViewCell.h"

@implementation AlbumTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
