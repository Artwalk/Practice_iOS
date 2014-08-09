//
//  testDetailViewController.m
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "testDetailViewController.h"

#import "Album.h"

@interface testDetailViewController ()
- (void)configureView;
@end

@implementation testDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.labelAlbumTitle.text = self.detailItem.title;
        self.LabelPrice.text = [NSString stringWithFormat:@"$%01.2f", self.detailItem.price];
        self.LabelArtist.text = self.detailItem.artist;
        self.LabelLocation.text = self.detailItem.locationInStore;
        self.textViewDescription.text = self.detailItem.summary;
    }
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
