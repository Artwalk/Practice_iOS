//
//  ViewController.m
//  7.6.Executing Non-UI Related Tasks Asynchronously with GCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
        __block UIImage *image = nil;
        
        dispatch_sync(concurrentQueue, ^{
            // Download image
            NSString *urlAsString = @"http://images.apple.com/osx/preview/images/overview_hero_bg_2x.jpg";
            NSURL *url = [NSURL URLWithString:urlAsString];
            NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
            
            NSError *downloadError = nil;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
            
            if (downloadError == nil && imageData != nil) {
                image = [UIImage imageWithData:imageData];
                NSLog(@"download OK!");
            } else if (downloadError != nil) {
                NSLog(@"downloadError %@", downloadError);
            } else {
                NSLog(@"No data");
            }
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Show image
            if (image != nil) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
                
                [imageView setImage:image];
                [imageView setContentMode:UIViewContentModeScaleAspectFit];
                [self.view addSubview:imageView];
            } else {
                NSLog(@"Image isn't downloaded");
            }
        });
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
