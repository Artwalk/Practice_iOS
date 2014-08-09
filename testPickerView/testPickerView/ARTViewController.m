//
//  ARTViewController.m
//  testPickerView
//
//  Created by artwalk on 6/30/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@implementation ARTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDatePicker = [[UIDatePicker alloc] init];
    self.myDatePicker.center = self.view.center;
    
    self.myDatePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    
    [self.view addSubview:self.myDatePicker];
    NSTimeInterval twoMinutes = 2*60;
    [self.myDatePicker setCountDownDuration:twoMinutes];
}

@end
