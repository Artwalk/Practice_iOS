//
//  ViewController.m
//  20.17.Screenshot
//
//  Created by artwalk on 8/28/14.
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    if ([self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES]) {
        NSLog(@"ok");
    } else {
        ;
    }
    
    UIImage *ss = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSURL *df = [fm URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    NSURL *ssUrl = [df URLByAppendingPathComponent:@"ss.png"];
    
    NSData *ssData = UIImagePNGRepresentation(ss);
    
    if ([ssData writeToURL:ssUrl atomically:YES]) {
        NSLog(@"wok");
    } else {
        
    }
    
}

@end
