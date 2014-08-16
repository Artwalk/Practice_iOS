//
//  ViewController.m
//  5.1.CollectionView
//
//  Created by artwalk on 8/9/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"
#import "Header.h"
#import "Footer.h"

static NSString *kCollectionViewCellIdentifier = @"Cells";
static NSString *kCollectionViewHeaderIdentifier = @"Header";
static NSString *kCollectionViewFooterIdentifier = @"Footer";
const NSTimeInterval kAnimationDuration = 0.50;

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self != nil) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
        
        UINib *headerNib = [UINib nibWithNibName:NSStringFromClass([Header class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionViewHeaderIdentifier];
        
        UINib *footerNib = [UINib nibWithNibName:NSStringFromClass([Footer class]) bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:footerNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kCollectionViewFooterIdentifier];
//        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    }
    
    return self;
}

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
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinches:)];
    for (UIGestureRecognizer *recognizer in self.collectionView.gestureRecognizers) {
        if ([recognizer isKindOfClass:[pinch class]]) {
            [recognizer requireGestureRecognizerToFail:pinch];
        }
    }
    [self.collectionView addGestureRecognizer:pinch];
}

- (void)handlePinches:(UIPinchGestureRecognizer *)paramSender {
    CGSize DefaultLayoutItemSize = CGSizeMake(80.0f, 120.0f);
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(DefaultLayoutItemSize.width * paramSender.scale, DefaultLayoutItemSize.height * paramSender.scale);
    
    [layout invalidateLayout];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return arc4random_uniform(21);
    return 3 + arc4random_uniform(4);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return [self allSectionColors].count;
    return 10 + arc4random_uniform(6);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = kCollectionViewHeaderIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reuseIdentifier = kCollectionViewFooterIdentifier;
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Header *header = (Header *)view;
        header.label.text = [NSString stringWithFormat:@"Section Header %lu", (unsigned long)indexPath.section + 1];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        Footer *footer = (Footer *)view;
        NSString *title = [NSString stringWithFormat:@"Seciton Footer %lu", (unsigned long)indexPath.section + 1];
        [footer.button setTitle:title forState:UIControlStateNormal];
    }
    
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [self allSectionColors][indexPath.section];

    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.imageViewBackgroundImage.image = [self randomImage];
    cell.imageViewBackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    const NSTimeInterval kAnimationDuration = 0.50;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        selectedCell.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            selectedCell.alpha = 1.0f;
        }];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
}

- (NSArray *)allSectionColors {
    static NSArray *allSectionColors = nil;
    if (allSectionColors == nil) {
        allSectionColors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    }
    
    return allSectionColors;
}

- (NSArray *)allImages {
    static NSArray *AllSectionImages = nil;
    if (AllSectionImages == nil) {
        AllSectionImages = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"]];
    }
    return AllSectionImages;
}

- (UIImage *)randomImage {
    return [self allImages][arc4random_uniform([self allImages].count)];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    if (action == @selector(copy:)) {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [[UIPasteboard generalPasteboard] setImage:cell.imageViewBackgroundImage.image];
    }
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
