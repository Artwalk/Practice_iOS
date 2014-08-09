//
//  testMasterViewController.m
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "testMasterViewController.h"

#import "testDetailViewController.h"

#import "Album.h"
#import "AlbumDataController.h"
#import "AlbumTableViewCell.h"

@interface testMasterViewController () {
    NSMutableArray *_objects;
}
@property (nonatomic, strong)AlbumDataController* albumDataController;
@end

@implementation testMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.albumDataController = [[AlbumDataController alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.albumDataController albumCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumCell" forIndexPath:indexPath];

    Album* album = [self.albumDataController albumAtIndex:indexPath.row];
    cell.laberAlbumTitle.text = album.title;
    cell.laberAlbumSummary.text = album.summary;
    cell.laberPrice.text = [NSString stringWithFormat:@"$%01.2f", album.price];
  
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAlbumDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Album* album = [self.albumDataController albumAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:album];
    }
}

@end
