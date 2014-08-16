//
//  ModelController.h
//  1.28.UIPageViewController
//
//  Created by artwalk on 7/23/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
