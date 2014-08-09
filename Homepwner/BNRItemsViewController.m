//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by artwalk on 6/2/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"
#import "BNRImageStore.h"
#import "BNRItemCell.h"
#import "BNRImageViewController.h"

@interface BNRItemsViewController () <UIPopoverControllerDelegate, UIDataSourceModelAssociation>

@property (nonatomic, strong) UIPopoverController *imagePopover;

@end

@implementation BNRItemsViewController

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    return [[self alloc] init];
}

- (IBAction)addNewItem:(id)sender {
//    NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
//    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navigationController.restorationIdentifier = NSStringFromClass([navigationController class]);
    
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (instancetype)init {
    //
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
//        for (int i = 0; i < 5; i++) {
//            [[BNRItemStore sharedStore] createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
        
        //
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        navItem.rightBarButtonItem = barButtonItem;
        
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(updateTableViewForDynamicTypeSize:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    [nc addObserver:self selector:@selector(localeChanged:) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    return self;
}

- (void)updateTableViewForDynamicTypeSize:(NSNotification *)note {
    [self.tableView reloadData];
}

- (void)localeChanged:(NSNotification *)note {
    [self.tableView reloadData];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRItemCell"];
    
    self.tableView.restorationIdentifier = @"BNRItemsViewControllerTableView";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell" forIndexPath:indexPath];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
//    cell.textLabel.text = [item description];
    
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    
    static NSNumberFormatter *currencyFormatter = nil;
    if (currencyFormatter == nil) {
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    cell.valueLabel.text = [currencyFormatter stringFromNumber:@(item.valueInDollars)];
//    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    cell.valueLabel.textColor = item.valueInDollars >50? [UIColor greenColor]:[UIColor redColor];

    cell.thumbnailView.image = item.thumbnail;
    
    __weak BNRItemCell *weakCell = cell;
    cell.actionBlock = ^ {
        NSLog(@"Going to show image for %@", item);
        
        BNRItemCell *strongCell = weakCell;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            NSString *itemKey = item.itemKey;
            // If there is no image, we don't need to display anything
            UIImage *img = [[BNRImageStore sharedStore] imageForKey:itemKey];
            if (!img) {
                return;
            }
            // Make a rectangle for the frame of the thumbnail relative to
            // our table view
            // Note: there will be a warning on this line that we'll soon discuss
            CGRect rect = [self.view convertRect:strongCell.thumbnailView.bounds
                                        fromView:strongCell.thumbnailView];
            // Create a new BNRImageViewController and set its image
            BNRImageViewController *ivc = [[BNRImageViewController alloc] init];
            ivc.image = img;
            // Present a 600x600 popover from the rect
            self.imagePopover = [[UIPopoverController alloc]
                                 initWithContentViewController:ivc];
            self.imagePopover.delegate = self;
            self.imagePopover.popoverContentSize = CGSizeMake(600, 600);
            [self.imagePopover presentPopoverFromRect:rect inView:self.view
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
        }
    };
    
    return cell;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.imagePopover = nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.isEditing forKey:@"TableViewIsEditing"];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    self.editing = [coder decodeBoolForKey:@"TableViewIsEditing"];
    
    [super decodeRestorableStateWithCoder:coder];
}

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view {
    NSString *identifier = nil;
    
    if (idx && view) {
        BNRItem *item = [[BNRItemStore sharedStore] allItems][idx.row];
        identifier = item.itemKey;
    }
    
    return identifier;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
    NSIndexPath *indexPath = nil;
    
    if (identifier && view) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        for (BNRItem *item in items) {
            if ([identifier isEqualToString:item.itemKey]) {
                int row = [items indexOfObject:item];
                indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                break;
            }
        }
    }
    
    return indexPath;
}

@end
