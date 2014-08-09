//
//  ARTViewController.m
//  UIProgressView
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()

@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation ARTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.center = self.view.center;
    self.progressView.progress = 2/3.0f;
    [self.view addSubview:self.progressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
