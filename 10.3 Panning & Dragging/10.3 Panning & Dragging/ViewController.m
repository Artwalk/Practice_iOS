//
//  ViewController.m
//  10.3 Panning & Dragging
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
- (IBAction)handlePanGestures:(UIPanGestureRecognizer *)sender {
    if (sender.state != UIGestureRecognizerStateEnded && sender.state != UIGestureRecognizerStateFailed) {
        CGPoint location = [sender locationInView:sender.view.superview];
//        sender.view.center = location;
        self.view.center = location;
    }
}

@end
