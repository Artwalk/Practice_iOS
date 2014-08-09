//
//  ARTViewController.m
//  Compass
//
//  Created by artwalk on 6/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

#define BARBUTTON(TITLE, SELECTOR)     [[[UIBarButtonItem alloc] initWithTitle:TITLE

@interface ARTViewController ()



@end

@implementation ARTViewController

@synthesize locManager,angel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locManager = [[CLLocationManager alloc] init];
    self.locManager.delegate = self;
    if ([CLLocationManager headingAvailable])
        [self.locManager startUpdatingHeading];
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"atention" message:@"compass not Available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        arrow.alpha = 0.0f;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager error: %@", [error description]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    CGFloat heading = -1.0f * M_PI * newHeading.magneticHeading / 180.0f;
    angel.text=[[NSString alloc]initWithFormat:@"angle:%f",newHeading.magneticHeading];
    arrow.transform = CGAffineTransformMakeRotation(heading);
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    return YES;
}

@end
