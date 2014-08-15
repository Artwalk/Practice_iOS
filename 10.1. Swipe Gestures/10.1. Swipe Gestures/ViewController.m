//
//  ViewController.m
//  10.1. Swipe Gestures
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGestureRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleSwipes:(id)sender {
    NSLog(@"swipe");
    UISwipeGestureRecognizer *swipeGestureRecognizer = (UISwipeGestureRecognizer *)sender;
    switch (swipeGestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"right");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"left");
            break;
        case UISwipeGestureRecognizerDirectionUp:
            NSLog(@"up");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            NSLog(@"down");
            break;
            
        default:
            NSLog(@"%d", swipeGestureRecognizer.direction);
            break;
    }
    
}

@end