//
//  SecondViewController.m
//  1.12.UINavigationController
//
//  Created by artwalk on 7/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)goBack {
//    [self.navigationController popViewControllerAnimated:YES];
    NSArray *currentControllers = self.navigationController.viewControllers;
    
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
//    NSLog(@"%@\n%@\n", currentControllers, newControllers);
    
    [newControllers removeLastObject];
    
//    self.navigationController.viewControllers = newControllers;
    [self.navigationController setViewControllers:newControllers animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(goBack) withObject:nil afterDelay:2.0f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Second Controller";
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
