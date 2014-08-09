//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by artwalk on 6/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;
@class BNRImageStore;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic, copy) void (^dismissBlock)(void);

- (instancetype)initForNewItem:(BOOL)isNew;

@property (strong, nonatomic) BNRItem *item;
@end
