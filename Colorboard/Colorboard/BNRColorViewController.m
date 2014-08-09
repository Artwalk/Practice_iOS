//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by artwalk on 6/10/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRColorViewController.h"

@implementation BNRColorViewController

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    
    NSLog(@"viewControllerWithRestorationIdentifierPath");
    BNRColorViewController *vc = nil;
    
    UIStoryboard* sb = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
    if (sb) {
        vc = (BNRColorViewController *)[sb instantiateViewControllerWithIdentifier:@"BNRColorViewController"];
        vc.restorationIdentifier = [identifierComponents lastObject];
        vc.restorationClass = [BNRColorViewController class];
    }
    return vc;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"encodeRestorableStateWithCoder");
    [super encodeRestorableStateWithCoder:coder];
}
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"decodeRestorableStateWithCoder");
    [super decodeRestorableStateWithCoder:coder];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.existingColor) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *color = self.colorDescription.color;
    
    CGFloat red, green, blue;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    self.view.backgroundColor = color;
    self.textField.text = self.colorDescription.name;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.colorDescription.name = self.textField.text;
    self.colorDescription.color = self.view.backgroundColor;
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)changeColor:(id)sender {
    
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor = newColor;
}

@end
