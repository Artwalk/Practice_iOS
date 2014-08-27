//
//  ViewController.m
//  20.0.Graphics & Animations
//
//  Created by artwalk on 8/27/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *img = [UIImage imageNamed:@"screen"];
    UIEdgeInsets ei = UIEdgeInsetsMake(14, 14, 14, 14);
    img = [img resizableImageWithCapInsets:ei];
    
    [self.button setBackgroundImage:img forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
