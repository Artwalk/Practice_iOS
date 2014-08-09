//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by artwalk on 6/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView {
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
