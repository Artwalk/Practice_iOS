//
//  ViewController.m
//  1.29.UIPopoverController
//
//  Created by artwalk on 7/26/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import "PopoverContentViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic, strong) UIPopoverController *myPopoverController;
@property (nonatomic, strong) UIBarButtonItem *barButtonAdd;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Class popoverClass = NSClassFromString(@"UIPopoverController");
    
    if (popoverClass != nil && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        PopoverContentViewController *content = [[PopoverContentViewController alloc] initWithNibName:nil bundle:nil];
        
        self.myPopoverController = [[UIPopoverController alloc] initWithContentViewController:content];
        content.myPopoverController = self.myPopoverController;
        
        self.barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAddWithPopover:)];
        
    } else {
        self.barButtonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(performAddWithAlertView:)];
    }
    
    [self.navigationItem setRightBarButtonItem:self.barButtonAdd animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) performAddWithAlertView:(id)paramSender {
    [[[UIAlertView alloc] initWithTitle:nil message:@"Add..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Photo", @"Audio", nil] show];
}

- (void) performAddWithPopover:(id)paramSender {
    [self.myPopoverController presentPopoverFromBarButtonItem:self.barButtonAdd permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
