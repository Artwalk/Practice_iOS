//
//  ViewController.m
//  4.8.TableView.Del
//
//  Created by artwalk on 8/8/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

static NSString *CellIdentifier = @"NumbersCellIdentifier";

static NSString *SectionOddNumbers = @"Odd Numbers";
static NSString *SectionEvenNumbers = @"Even Numbers";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViewNumbers;
@property (nonatomic, strong) NSMutableDictionary *dictionaryOfNumbers;
@property (nonatomic, strong) UIBarButtonItem *barButtonAction;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.barButtonAction = [[UIBarButtonItem alloc] initWithTitle:@"Delete Numbers > 2" style:UIBarButtonItemStylePlain target:self action:@selector(deleteNumbersGreaterThan2:)];
    
    [self.navigationItem setRightBarButtonItem:self.barButtonAction animated:NO];
    
    self.tableViewNumbers = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.tableViewNumbers registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableViewNumbers.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableViewNumbers.delegate = self;
    self.tableViewNumbers.dataSource = self;
    
    [self.view addSubview:self.tableViewNumbers];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dictionaryOfNumbers.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionNameInDictionary = self.dictionaryOfNumbers.allKeys[section];
    NSArray *sectionArray = self.dictionaryOfNumbers[sectionNameInDictionary];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *sectionNameInDictionary = self.dictionaryOfNumbers.allKeys[indexPath.section];
    
    NSArray *sectionArray = self.dictionaryOfNumbers[sectionNameInDictionary];
    
    NSNumber *number = sectionArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[number unsignedIntegerValue]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dictionaryOfNumbers.allKeys[section];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dictionaryOfNumbers {

    if (_dictionaryOfNumbers == nil) {
        NSMutableArray *arrayOfEvenNumbers = [[NSMutableArray alloc] initWithArray:@[@0, @2, @4, @6,]];
        NSMutableArray *arrayOfOddNumbers = [[NSMutableArray alloc] initWithArray:@[@1, @3, @5, @7,]];
        
        _dictionaryOfNumbers = [[NSMutableDictionary alloc] initWithDictionary:@{SectionEvenNumbers: arrayOfEvenNumbers, SectionOddNumbers:arrayOfOddNumbers, }];
    }
    
    return _dictionaryOfNumbers;
}

- (void)deleteOddNumbersSection:(id)paramSender {
    NSString *key = SectionOddNumbers;
    NSInteger indexForKey = [[self.dictionaryOfNumbers allKeys] indexOfObject:key];
    
    if (indexForKey == NSNotFound) {
        return;
    }
    [self.dictionaryOfNumbers removeObjectForKey:key];
    
    NSIndexSet *sectionToDelete = [NSIndexSet indexSetWithIndex:indexForKey];
    [self.tableViewNumbers deleteSections:sectionToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)deleteNumbersGreaterThan2:(id)paramSender {
    NSMutableArray *arrayOfIndexPathsToDelete = [[NSMutableArray alloc] init];
    NSMutableArray *arrayOfNumberObjectsToDelete = [[NSMutableArray alloc] init];
    
    __block NSUInteger keyIndex = 0;
    [self.dictionaryOfNumbers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj unsignedIntegerValue] > 2) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:keyIndex];
                [arrayOfIndexPathsToDelete addObject:indexPath];
                [arrayOfNumberObjectsToDelete addObject:obj];
            }
        }];
        keyIndex++;
    }];
    
    if ([arrayOfNumberObjectsToDelete count] > 0) {
        NSMutableArray *arrayOfOddNumbers = self.dictionaryOfNumbers[SectionOddNumbers];
        NSMutableArray *arrayOfEvenNumbers = self.dictionaryOfNumbers[SectionEvenNumbers];
        
        [arrayOfNumberObjectsToDelete enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([arrayOfOddNumbers indexOfObject:obj] != NSNotFound) {
                [arrayOfOddNumbers removeObject:obj];
            }
            if ([arrayOfEvenNumbers indexOfObject:obj] != NSNotFound) {
                [arrayOfEvenNumbers removeObject:obj];
            }
        }];
    }
    
    [self.tableViewNumbers deleteRowsAtIndexPaths:arrayOfIndexPathsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}


@end
