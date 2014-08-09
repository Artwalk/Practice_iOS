//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by artwalk on 6/5/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@end

@implementation BNRImageViewController

- (void)loadView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *imageView = (UIImageView *)self.view;
    imageView.image = self.image;
}

@end
