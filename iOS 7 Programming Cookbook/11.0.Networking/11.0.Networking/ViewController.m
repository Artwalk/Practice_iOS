//
//  ViewController.m
//  11.0.Networking
//
//  Created by artwalk on 8/16/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

typedef void(^Operation)(NSData *data);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self getHtml:@"http://www.apple.com"];
    [self downloadHtml:@"http://www.douban.com"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadHtml:(NSString *)urlAsString {
    [self constactContection:urlAsString withOperation:^(NSData *data) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *filePath = [fileManager URLForDirectory:NSDocumentDirectory
                                              inDomain:NSUserDomainMask
                                     appropriateForURL:nil
                                                create:NO
                                                 error:nil];
        filePath = [filePath URLByAppendingPathComponent:@"apple.html"];
        [data writeToURL:filePath atomically:YES];
    }];
}

- (void)getHtml:(NSString *)urlAsString {
    [self constactContection:urlAsString withOperation:^(NSData *data) {
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", html);
    }];
}

- (void)constactContection:(NSString *)urlAsString withOperation:(Operation)operation {
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            // do something diff
            operation(data);
        } else if ([data length] == 0 && connectionError == nil) {
            NSLog(@"Nothing was downloaded");
        } else if (connectionError != nil) {
            NSLog(@"%@", connectionError);
        }
    }];
}

@end
