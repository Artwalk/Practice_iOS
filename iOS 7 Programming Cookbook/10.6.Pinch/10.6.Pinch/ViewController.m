//
//  ViewController.m
//  10.6.Pinch
//
//  Created by artwalk on 8/16/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, unsafe_unretained) CGFloat currentScale;
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
- (IBAction)handlePinches:(UIPinchGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.currentScale = sender.scale;
    } else if (sender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f) {
        sender.scale = self.currentScale;
    }
    
    if (sender.scale != NAN && sender.scale != 0.0) {
        sender.view.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
    }
}

@end
