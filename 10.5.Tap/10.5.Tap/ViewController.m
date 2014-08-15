//
//  ViewController.m
//  10.5.Tap
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleTaps:(UITapGestureRecognizer *)sender {
    NSLog(@"hehe");
    for (int i = 0; i < sender.numberOfTapsRequired; ++i) {
        CGPoint touchPoint = [sender locationOfTouch:i inView:sender.view];
        NSLog(@"#%d, %@", i+i, NSStringFromCGPoint(touchPoint));
    }
}

@end
