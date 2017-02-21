//
//  SongListTableViewController.m
//  NTD-ThoiNguoiOLaiEmDi
//
//  Created by Thinh Le on 3/7/16.
//  Copyright © 2016 Lac Viet Inc. All rights reserved.
//

#import "SongListTableViewController.h"
#import "PlaySongViewController.h"

@interface SongListTableViewController () {
    int _songIndex;
//    NSString * _songTitle;
//    NSString * _songWriter;
//    NSArray  * _songListArray;
}
@end

@implementation SongListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"SongList", @"SongList") ofType:@"plist"];
    
    //init the file
    //self.songIndex = -1;
    self.songList = [[NSArray alloc] initWithContentsOfFile:resourcePath];
    self.navigationItem.title = @"Nguyễn Tiến Dũng - Thôi! Người Ở Lại Em Đi";
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    cell.imageView.image = [UIImage imageNamed:@"NTD-TNOLED-CD-44x44.png"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    cell.textLabel.textColor= [UIColor darkGrayColor];
    cell.textLabel.text = [[self.songList objectAtIndex:indexPath.row] objectForKey:@"engChapTitle"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.textColor= [UIColor brownColor];
    cell.detailTextLabel.text = [[self.songList objectAtIndex:indexPath.row] objectForKey:@"2ndLangChapTitle"];
    
    return cell;
}

#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _songIndex     = (int)indexPath.row;
    //NSLog(@"song title %d", _songIndex);
    [self performSegueWithIdentifier:@"PlayNextSong" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PlayNextSong"]) {
        PlaySongViewController * playSongViewController = (PlaySongViewController*)segue.destinationViewController;
        playSongViewController.songIndex  = _songIndex;
    }
}

@end
