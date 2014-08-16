//
//  ARTViewController.m
//  1.15.UIBarButtonItem
//
//  Created by artwalk on 7/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()

@end

@implementation ARTViewController

- (void)perforAdd:(id)paramSender {
    NSLog(@"Action method got called.");
}

- (void)switchIsChanged:(UISwitch *)paramSender {
    if ([paramSender isOn]) {
        NSLog(@"Switch is on");
    } else {
        NSLog(@"Switch is off");
    }
}

- (void)segmentedControlTapped:(UISegmentedControl *)paramSender {
    switch (paramSender.selectedSegmentIndex) {
        case 0:
            NSLog(@"Up");
            break;
        case 1:
            NSLog(@"Down");
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"First Controller";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(perforAdd:)];
    
//    UISwitch *simpleSwith = [[UISwitch alloc] init];
//    simpleSwith.on = YES;
//    
//    [simpleSwith addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:simpleSwith];

    NSArray *items = @[@"Up", @"Down"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.momentary = YES;
    
    [segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:segmentedControl] ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
