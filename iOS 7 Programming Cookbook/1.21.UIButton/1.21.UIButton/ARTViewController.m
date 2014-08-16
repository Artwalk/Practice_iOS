//
//  ARTViewController.m
//  1.21.UIButton
//
//  Created by artwalk on 7/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()

@property (nonatomic, strong) UIButton *myButton;

@end

@implementation ARTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.myButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    self.myButton.frame = CGRectMake(110.0f, 200.0f, 100.0f, 44.0f);
    
    [self.myButton setTitle:@"Press Me" forState:UIControlStateNormal];
    [self.myButton setTitle:@"I'm Pressed" forState:UIControlStateHighlighted];
    [self.myButton addTarget:self action:@selector(buttonIsPressed:) forControlEvents:UIControlEventTouchDown];
    [self.myButton addTarget:self action:@selector(buttonIsTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.myButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonIsPressed:(UIButton *)paramSender {
    NSLog(@"pressed");
}

- (void)buttonIsTapped:(UIButton *)paramSender {
    NSLog(@"tapped");
}

@end
