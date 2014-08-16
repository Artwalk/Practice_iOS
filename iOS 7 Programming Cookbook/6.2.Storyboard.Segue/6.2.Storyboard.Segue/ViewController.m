//
//  ViewController.m
//  6.2.Storyboard.Segue
//
//  Created by artwalk on 8/10/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)displayTextIsRequired {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter some text in the text field" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alertView show];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"pushSecondViewController"]) {
        if ([self.textField.text length] == 0) {
            [self displayTextIsRequired];
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushSecondViewController"]) {
        SecondViewController *nextController = segue.destinationViewController;
        [nextController setTitle:self.textField.text];
    }
}

@end
