//
//  ViewController.m
//  1.8.UISegmented
//
//  Created by artwalk on 7/5/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UISegmentedControl *mySegmentedControl;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *segments = [[NSArray alloc] initWithObjects:@"iPhone", @"iPad", @"iPod", @"iMac", nil];

    self.mySegmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    self.mySegmentedControl.center = self.view.center;
    [self.view addSubview:self.mySegmentedControl];

    [self.mySegmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentChanged:(UISegmentedControl *)paramSender {
    if ([paramSender isEqual:self.mySegmentedControl]) {
        NSInteger selectedSegmentIndex = [paramSender selectedSegmentIndex];

        NSString *selectedSegmentText = [paramSender titleForSegmentAtIndex:selectedSegmentIndex];

        NSLog(@"%ld, %@", (
                long) selectedSegmentIndex, selectedSegmentText);
    }
}

@end