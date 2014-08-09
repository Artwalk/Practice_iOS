//
//  ARTViewController.m
//  1.17.UILabel
//
//  Created by artwalk on 7/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *myLabel;

@property (nonatomic, strong) UITextField *myTextField;

@property (nonatomic, strong) UILabel *labelCounter;
@end

@implementation ARTViewController

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
    
    [self testTextField1];
}

- (void)calculateAndDisplayTextFieldLengthWithText:(NSString *)paramText {
    NSString *characterOrCharacters = @"Characters";
    if ([paramText length] == 1) {
         characterOrCharacters = @"Character";
    }
    
    self.labelCounter.text = [NSString stringWithFormat:@"%lu %@", (unsigned long)[paramText length], characterOrCharacters];
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.myTextField]) {
        NSString *wholeText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        [self calculateAndDisplayTextFieldLengthWithText:wholeText];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)testLabel1 {
    //    CGRect labelFrame = CGRectMake(0.0f, 0.0f, 100.0f, 70.0f);
    //    self.myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    ////    self.myLabel.numberOfLines = 0;
    ////    self.myLabel.lineBreakMode = NSLineBreakByWordWrapping;
    //    self.myLabel.adjustsFontSizeToFitWidth = YES;
    //    self.myLabel.text = @"iOS 7 Programming Cookbook";
    //    self.myLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    //    self.myLabel.center = self.view.center;
    //    [self.view addSubview:self.myLabel];
}

- (void)testLabel2 {
    self.myLabel = [[UILabel alloc] init];
    self.myLabel.backgroundColor = [UIColor clearColor];
    self.myLabel.text = @"iOS SDK";
    self.myLabel.font = [UIFont boldSystemFontOfSize:70.0f];
    self.myLabel.textColor = [UIColor blackColor];
    self.myLabel.shadowColor = [UIColor lightGrayColor];
    self.myLabel.shadowOffset = CGSizeMake(2.0f, 2.0f);
    [self.myLabel sizeToFit];
    self.myLabel.center = self.view.center;
    [self.view addSubview:self.myLabel];
}

- (void)testTextField1 {
    CGRect textFieldFrame = CGRectMake(38.0f, 90.0f, 220.0f, 31.0f);
    
    self.myTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
    self.myTextField.delegate = self;
    self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.myTextField.textAlignment = NSTextAlignmentCenter;
    self.myTextField.text = @"Sir Richard Branson";
    [self.view addSubview:self.myTextField];
    
    UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    currencyLabel.text = [[[NSNumberFormatter alloc] init] currencySymbol];
    currencyLabel.font = self.myTextField.font;
    [currencyLabel sizeToFit];
    
    self.myTextField.leftView = currencyLabel;
    self.myTextField.leftViewMode = UITextFieldViewModeAlways;
    
    CGRect labelCounterFrame = self.myTextField.frame;
    labelCounterFrame.origin.y += textFieldFrame.size.height + 10;
    self.labelCounter = [[UILabel alloc] initWithFrame:labelCounterFrame];
    [self.view addSubview:self.labelCounter];
    
    [self calculateAndDisplayTextFieldLengthWithText:self.myTextField.text];
}

- (void)testTextField {
    CGRect textFiledFrame = CGRectMake(0.0f, 0.0f, 200.0f, 31.0f);
    self.myTextField = [[UITextField alloc] initWithFrame:textFiledFrame];
    self.myTextField.delegate = self;
    self.myTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.myTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.myTextField.textAlignment = NSTextAlignmentCenter;
    
      self.myTextField.text = @"Sir Richard Branson";
    self.myTextField.center = self.view.center;
    
    [self.view addSubview:self.myTextField];
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
