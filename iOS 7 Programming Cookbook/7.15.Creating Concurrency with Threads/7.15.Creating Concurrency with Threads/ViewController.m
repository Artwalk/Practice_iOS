//
//  ViewController.m
//  7.15.Creating Concurrency with Threads
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)downloadNewFile:(id)paramObject {
    NSString *fileURL = (NSString *)paramObject;
    NSURL *url = [NSURL URLWithString:fileURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    
    NSError *error = nil;
    NSData *downloadedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if ([downloadedData length]) {
        NSLog(@"OK");
    } else {
        
    }
}

- (void)counter:(int)index {
    @autoreleasepool {
        NSUInteger i;
        for (i = 0; i < 10; ++i) {
            NSLog(@"%d  ---> %lu",index, (unsigned long)i);
        }
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"MacBook Pro" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        NSLog(@"%@", image);
    }
}

- (void)firstCounter {
    [self counter:1];
}

- (void)secondCounter {
    [self counter:2];
}

- (void)thirdCounter {
    [self counter:3];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *fileToDownload = @"http://www.OReilly.com";
    
    [NSThread detachNewThreadSelector:@selector(downloadNewFile:) toTarget:self withObject:fileToDownload];
    
    [NSThread detachNewThreadSelector:@selector(firstCounter) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(secondCounter) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(thirdCounter) toTarget:self withObject:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
