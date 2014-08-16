//
//  ARTViewController.m
//  1.20.UITextView
//
//  Created by artwalk on 7/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController ()

@property (nonatomic, strong) UITextView *myTextView;

@end

@implementation ARTViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.myTextView = [[UITextView alloc] initWithFrame:self.view.bounds];
    self.myTextView.text = @"Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...Some text here...";
    
    self.myTextView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    self.myTextView.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:self.myTextView];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (void)handleKeyboardDidShow:(NSNotification *)paramNotification {
    NSValue *keyboardRectAsObject = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = CGRectZero;
    
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.myTextView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, keyboardRect.size.height, 0.0f);
}

- (void)handleKeyboardWillHide:(NSNotification *)paramNotification {
    self.myTextView.contentInset = UIEdgeInsetsZero;
}

@end
