//
//  BNRItemCell.m
//  Homepwner
//
//  Created by artwalk on 6/5/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell
- (IBAction)showImage:(id)sender {
    NSLog(@"sb");
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
