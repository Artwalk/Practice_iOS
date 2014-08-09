//
//  ARTViewController.m
//  1.23.UIScrollview
//
//  Created by artwalk on 7/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ARTViewController.h"

@interface ARTViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIImageView *myImageView;

@end

@implementation ARTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    CGRect scrollViewRect = self.view.bounds;
    
    self.myScrollView = [[UIScrollView alloc] initWithFrame:scrollViewRect];
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0f, scrollViewRect.size.height);
    
    [self.view addSubview:self.myScrollView];
    
    
    [self flipImageView];
   
    
    //    [self.myScrollView setShowsVerticalScrollIndicator:NO];
    [self.myScrollView setShowsHorizontalScrollIndicator:NO];
    [self.myScrollView setBounces:NO];
    self.myScrollView.delegate = self;
    [self.myScrollView setContentOffset:CGPointMake(scrollViewRect.size.width, 0)];
    
    //    UIImage *imageToLoad = [UIImage imageNamed:@"obj-c"];
    //    self.myImageView = [[UIImageView alloc] initWithImage:imageToLoad];
    //    self.myScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //    [self.myScrollView addSubview:self.myImageView];
    //    self.myScrollView.contentSize = self.myImageView.bounds.size;
    //    self.myScrollView.delegate = self;
    //    [self.view addSubview:self.myScrollView];
    //
    //    self.myScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
    
    
}


- (UIImageView *)newImageViewWithImage:(UIImage *)paramImage frame:(CGRect)paramFrame {
    UIImageView *result = [[UIImageView alloc] initWithFrame:paramFrame];
    result.contentMode = UIViewContentModeScaleAspectFit;
    result.image = paramImage;
    return     result;
}

- (void) flipImageView {
    UIImage *one = [UIImage imageNamed:@"fakeYesterday"];
    UIImage *two = [UIImage imageNamed:@"fakeYesterday"];
    UIImage *three = [UIImage imageNamed:@"fakeYesterday"];
    
    CGRect imageViewRect = self.view.bounds;
    UIImageView *oneImageView = [self newImageViewWithImage:one frame:imageViewRect];
    [self.myScrollView addSubview:oneImageView];
    
    imageViewRect.origin.x += imageViewRect.size.width;
    UIImageView *twoImageView = [self newImageViewWithImage:two frame:imageViewRect];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 100, 20)];
//    label.center = twoImageView.center;
    label.text = @"hehe";
    [twoImageView addSubview:label];
    
    [self.myScrollView addSubview:twoImageView];
    
    
    imageViewRect.origin.x += imageViewRect.size.width;
    UIImageView *threeImageView = [self newImageViewWithImage:three frame:imageViewRect];
    [self.myScrollView addSubview:threeImageView];

}

- (void) flipView{
    CGRect viewRect = self.view.bounds;
    UIView *oneView = [[UIView alloc] initWithFrame:viewRect];
    oneView.backgroundColor = [UIColor redColor];
    [self.myScrollView addSubview:oneView];
    
    
    viewRect.origin.x += viewRect.size.width;
    oneView = [[UIView alloc] initWithFrame:viewRect];
    oneView.backgroundColor = [UIColor blueColor];
    [self.myScrollView addSubview:oneView];
    
    
    viewRect.origin.x += viewRect.size.width;
    oneView = [[UIView alloc] initWithFrame:viewRect];
    oneView.backgroundColor = [UIColor greenColor];
    [self.myScrollView addSubview:oneView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll");
//    self.myScrollView.alpha = 0.5f;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating, %f", scrollView.contentOffset.x);
    if (scrollView.contentOffset.x < 320) {
        NSLog(@"last day");
    } else {
        NSLog(@"next day");
    }
    
    self.myScrollView.contentOffset = CGPointMake(self.view.bounds.size.width , 0);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging %f", scrollView.contentOffset.x);
    
    //    self.myScrollView.alpha = 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
