//
//  ARTViewController.m
//  1.24.UIWebView
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()  <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *myWebView;

@end

@implementation ARTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.myWebView.scalesPageToFit = YES;
    [self.view addSubview:self.myWebView];

//    NSString *htmlString = @"<br/>iOS 7 Programming <strong>Cookbook</strong>";
    NSURL *url = [NSURL URLWithString:@"http://www.apple.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];

//    [self.myWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
