//
//  ViewController.m
//  4.0.UITableView
//
//  Created by artwalk on 7/26/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"

static NSString *CellIdentifier = @"MyCells";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *arrayOfSections;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.myTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    

    [self.view addSubview:self.myTableView];
    
//    [self moveSection1ToSection3];
//    [self moveCell1InSection1ToCell2InSection1];
    [self moveCell2InSection1ToCellInSection2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)newSectionWithIndex:(NSUInteger)paramIndex cellCount:(NSUInteger)paramCellCount {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSUInteger counter = 0;
    for (counter = 0; counter < paramCellCount; counter++) {
        [result addObject:[[NSString alloc] initWithFormat:@"Section %lu Cell %lu", (unsigned long)paramIndex, (unsigned long)counter+1]];
    }
    
    return result;
}

- (NSMutableArray *)arrayOfSections {
    if (_arrayOfSections == nil) {
        NSMutableArray *section1 = [self newSectionWithIndex:1 cellCount:3];
        NSMutableArray *section2 = [self newSectionWithIndex:2 cellCount:3];
        NSMutableArray *section3 = [self newSectionWithIndex:3 cellCount:3];
        
        _arrayOfSections = [[NSMutableArray alloc] initWithArray:@[section1, section2, section3]];
    }
    
    return _arrayOfSections;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayOfSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = self.arrayOfSections[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *sectionArray = self.arrayOfSections[indexPath.section];
    
    cell.textLabel.text = sectionArray[indexPath.row];
    
    return cell;
}

- (void)moveSection1ToSection3 {
    NSMutableArray *section1 = self.arrayOfSections[0];
    [self.arrayOfSections removeObject:section1];
    [self.arrayOfSections addObject:section1];
    
    [self.myTableView moveSection:0 toSection:2];
}

- (void)moveCell1InSection1ToCell2InSection1 {
    NSMutableArray *section1 = self.arrayOfSections[0];
    NSString *cell1InSection1 = section1[0];
    
    [section1 removeObject:cell1InSection1];
    [section1 insertObject:cell1InSection1 atIndex:1];
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.myTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

- (void)moveCell2InSection1ToCellInSection2 {
    NSMutableArray *section1 = self.arrayOfSections[0];
    NSMutableArray *section2 = self.arrayOfSections[1];
    
    NSString *cell2InSection1 = section1[1];
    [section1 removeObject:cell2InSection1];
    
    [section2 insertObject:cell2InSection1 atIndex:0];
    
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.myTableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    
}

@end
