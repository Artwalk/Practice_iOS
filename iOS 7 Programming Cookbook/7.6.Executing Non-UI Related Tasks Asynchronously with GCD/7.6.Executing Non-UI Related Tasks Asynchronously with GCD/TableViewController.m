//
//  TableViewController.m
//  7.6.Executing Non-UI Related Tasks Asynchronously with GCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSArray *list;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
        NSUInteger numberOfValuesRequired = 10000;
        
        if ([self hasFileAlreadyBeenCreated] == NO) {
            dispatch_sync(concurrentQueue, ^{
                NSMutableArray *arrayOfRandomNumbers = [[NSMutableArray alloc] initWithCapacity:numberOfValuesRequired];
                
                
                NSUInteger counter = 0;
                for (counter = 0; counter < numberOfValuesRequired; counter++) {
                    unsigned int randomNumber = arc4random() % ((unsigned int)RAND_MAX +1);
                    
                    [arrayOfRandomNumbers addObject:[NSNumber numberWithUnsignedInt:randomNumber]];
                    
                }
                [arrayOfRandomNumbers writeToFile:[self fileLocation] atomically:YES];
            });
        }
        
        __block NSMutableArray *randomNumbers = nil;
        
        dispatch_sync(concurrentQueue, ^{
            if ([self hasFileAlreadyBeenCreated]) {
                randomNumbers = [[NSMutableArray alloc] initWithContentsOfFile:[self fileLocation]];
                
                [randomNumbers sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    NSNumber *number1 = (NSNumber *)obj1;
                    NSNumber *number2 = (NSNumber *)obj2;
                    return [number1 compare:number2];
                }];
            }
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([randomNumbers count] > 0) {
                // refresh UI
                self.list = randomNumbers;
                [self.tableView reloadData];
            }
        });
        
    });
}

#pragma mark - init
- (NSString *)fileLocation {
    NSArray *folders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if ([folders count] == 0) {
        return nil;
    }
    
    NSString *doucumentsFolder = folders[0];
    
    return [doucumentsFolder stringByAppendingPathComponent:@"list.txt"];
}

- (BOOL)hasFileAlreadyBeenCreated {
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:[self fileLocation]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)[self.list[indexPath.row] integerValue]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
