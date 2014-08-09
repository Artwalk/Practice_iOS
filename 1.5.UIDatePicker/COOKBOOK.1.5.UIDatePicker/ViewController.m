//
//  ViewController.m
//  COOKBOOK.1.5.UIDatePicker
//
//  Created by artwalk on 7/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()
@property(nonatomic, strong) UIDatePicker *myDatePicker;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    self.myDatePicker = [[UIDatePicker alloc] init];
    self.myDatePicker.center = self.view.center;
//    self.myDatePicker.datePickerMode = UIDatePickerModeDate;
    self.myDatePicker.datePickerMode = UIDatePickerModeCountDownTimer;

    [self.view addSubview:self.myDatePicker];

//    NSTimeInterval  oneYearTime = 2*60;
//    NSDate *todayDate = [NSDate date];

//    NSDate *oneYearFromToday = [todayDate dateByAddingTimeInterval:oneYearTime];
//    NSDate *twoYearFromToday = [todayDate dateByAddingTimeInterval:2*oneYearTime];

//    self.myDatePicker.minimumDate = oneYearFromToday;
//    self.myDatePicker.maximumDate = twoYearFromToday;
    NSTimeInterval twoMinutes = 0 ;
    [self.myDatePicker setCountDownDuration:twoMinutes];

//    [self.myDatePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker {
//    if ([paramDatePicker isEqual:self.myDatePicker]) {
//        NSLog(@"Selected date = %@", paramDatePicker.date);
//    }
//}


@end