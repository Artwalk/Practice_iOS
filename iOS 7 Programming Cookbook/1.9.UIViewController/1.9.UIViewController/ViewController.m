//
//  ViewController.m
//  1.9.UIViewController
//
//  Created by artwalk on 7/6/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import "StringReverserActivity.h"

@interface ViewController () <UITextFieldDelegate>
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *buttonShare;
@property(nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSArray *itemsToShare = @[@"Item 1", @"Item 2"];

    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:@[[StringReverserActivity new]] ];

    [self presentViewController:activity animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self createButton];
//    [self createTextField];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTextField {
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 35.0f, 280.0f, 30.0f)];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"Enter text to share...";
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}


- (void)createButton {
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonShare.translatesAutoresizingMaskIntoConstraints = NO;
    self.buttonShare.frame = CGRectMake(20.0f, 80.0f, 280.0f, 44.0f);
    [self.buttonShare setTitle:@"Share" forState:UIControlStateNormal];

    [self.buttonShare addTarget:self action:@selector(handleShare:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonShare];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)handleShare:(id)paramSender {
    if ([self.textField.text length] == 0) {
        NSString *message = @"Please enter a text and then press Share";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [alertView show];
        return;
    }

    self.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.textField.text] applicationActivities:nil];
    [self presentViewController:self.activityViewController animated:YES completion:^{

    }];
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
