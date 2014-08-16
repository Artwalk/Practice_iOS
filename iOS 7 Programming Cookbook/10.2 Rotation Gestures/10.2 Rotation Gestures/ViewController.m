//
//  ViewController.m
//  10.2 Rotation Gestures
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationGestureRecognizer;

@property (nonatomic, unsafe_unretained) CGFloat rotationAngleInRadians;

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
- (IBAction)handleRotations:(UIRotationGestureRecognizer *)sender {
    if (self.label == nil) {
        return;
    }
    
    self.label.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians + sender.rotation);
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.rotationAngleInRadians += sender.rotation;
    }
    
    NSLog(@"%f", self.rotationAngleInRadians);
}


@end
