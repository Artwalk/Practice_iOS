//
//  ViewController.m
//  17.3.Keyboard Notifications
//
//  Created by artwalk on 8/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardWillShow:(NSNotification *)notification {
    NSDictionary *useInfo = notification.userInfo;
    
    NSValue *animaDuraObj = useInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    NSValue *keyboardEndRectObj = useInfo[UIKeyboardFrameEndUserInfoKey];
    
    double animaDura = 0.0;
    CGRect keyboardEndRect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    
    [animaDuraObj getValue:&animaDura];
    [keyboardEndRectObj getValue:&keyboardEndRect];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    keyboardEndRect = [self.view convertRect:keyboardEndRect fromView:window];
    
    CGRect intersectionOfKeyboardRectAndWindowRect = CGRectIntersection(self.view.frame, keyboardEndRect);
    
    [UIView animateWithDuration:animaDura animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, intersectionOfKeyboardRectAndWindowRect.size.height, 0.0f);
        [self.scrollView scrollRectToVisible:self.textField.frame animated:NO];
    }];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    NSDictionary *useInfo = notification.userInfo;
    
    NSValue *animaDuraObj = useInfo[UIKeyboardAnimationDurationUserInfoKey];

    double animaDura =0.0;
    
    [animaDuraObj getValue:&animaDura];
    
    [UIView animateWithDuration:animaDura animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
