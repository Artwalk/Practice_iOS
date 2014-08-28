//
//  ViewController.m
//  20.14,Moving Views
//
//  Created by artwalk on 8/28/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect topRect = CGRectMake(0, 20, 63, 63);
    CGRect bottomRect =self.imageView2.frame;
    
    [self.imageView setFrame:topRect];
    [self myAnimationWithEndRect:bottomRect imageView:self.imageView delay:0];
    [self.imageView setFrame:bottomRect];
    [self myAnimationWithEndRect:topRect imageView:self.imageView2 delay:1];
}

- (void) myAnimationWithEndRect:(CGRect)rect imageView:(UIImageView *)imageView delay:(CGFloat)delay {
    static int i = 0;
    NSString *s = [NSString stringWithFormat:@"iv%dAnima" ,++i];
    NSLog(@"%@", s);
//    imageView.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:s context:(__bridge void *)imageView];
    
    [UIView setAnimationDuration:5];
    [UIView setAnimationDelay:delay];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ivDidStop:finished:context:)];
    
//    imageView.transform = CGAffineTransformMakeScale(2, 2);
//    imageView.transform = CGAffineTransformMakeRotation((180 * M_PI)/180);
    [imageView setFrame:rect];
//    [imageView setAlpha:0];
    [UIView commitAnimations];
}

- (void)ivDidStop:(NSString *)animID finished:(NSNumber *)finished context:(void *)context {
    UIImageView *iv = (__bridge UIImageView *)context;
    [iv removeFromSuperview];
    NSLog(@"finished");
    NSLog(@"ID --> %@, iv -- >%@", animID, (__bridge UIImageView *)context);
}

@end
