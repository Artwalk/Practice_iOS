//
//  ViewController.m
//  CB.1.6.UISlider
//
//  Created by artwalk on 7/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()

@property(nonatomic, strong) UISlider *slider;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 118.0f, 23.0f)];

    self.slider.center = self.view.center;
    self.slider.minimumValue = 0.0f;
    self.slider.maximumValue = 1.0f;
    self.slider.value = 0.5;
    [self.view addSubview:self.slider];

    self.slider.minimumTrackTintColor = [UIColor redColor];
    self.slider.maximumTrackTintColor = [UIColor greenColor];
    self.slider.thumbTintColor = [UIColor blueColor];

    [self.slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sliderValueChanged:(UISlider *)paramSender {
    if ([paramSender isEqual:self.slider]) {
        NSLog(@"%f", paramSender.value);
    }
}

@end