//
//  ViewController.m
//  10.4.Long-Press
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *dummyButton;

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

- (IBAction)handleLongPressGestures:(UILongPressGestureRecognizer *)sender {
    NSLog(@"%@", sender);
    if ([sender isEqual:self.longPressGestureRecognizer]) {
        if (sender.numberOfTouchesRequired == 2) {
            CGPoint touchPoint1 = [sender locationOfTouch:0 inView:sender.view];
            CGPoint touchPoint2 = [sender locationOfTouch:1 inView:sender.view];
            
            CGFloat midPointX = (touchPoint1.x + touchPoint2.x) / 2.0f;
            CGFloat midPointY = (touchPoint1.y + touchPoint2.y) / 2.0f;
            
            CGPoint midPoint = CGPointMake(midPointX, midPointY);
            
            self.dummyButton.center = midPoint;
        }
    }
    
    
}
@end
