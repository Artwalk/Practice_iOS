//
//  ARTViewController.m
//  1.26.UILable
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ARTViewController

- (NSAttributedString *) attributedText {
    NSString *string = @"iOS SDK";
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];

    NSDictionary *attributesForFirstWord = @{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:60.0f],
            NSForegroundColorAttributeName:[UIColor redColor],
            NSBackgroundColorAttributeName:[UIColor blackColor]
    };
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor darkGrayColor];
    shadow.shadowOffset = CGSizeMake(4.0f, 4.0f);

    NSDictionary *attributesForSecondWord = @{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:70.0f],
            NSForegroundColorAttributeName:[UIColor whiteColor],
            NSBackgroundColorAttributeName:[UIColor redColor],
            NSShadowAttributeName:shadow
    };

    [result setAttributes:attributesForFirstWord range:[string rangeOfString:@"i"]];
    [result setAttributes:attributesForSecondWord range:[string rangeOfString:@"SD"]];

    return [[NSAttributedString alloc] initWithAttributedString:result];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.label = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.attributedText = [self attributedText];
    [self.label sizeToFit];
    self.label.center = self.view.center;
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
