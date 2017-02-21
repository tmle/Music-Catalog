//
//  PlaySongViewController.m
//  NTD-ThoiNguoiOLaiEmDi
//
//  Created by Thinh Le on 3/7/16.
//  Copyright © 2016 Lac Viet Inc. All rights reserved.
//

#import "SongListTableViewController.h"
#import "PlaySongViewController.h"
#import <UIKit/UIBarItem.h>
//#import <AVFoundation/AVFoundation.h>

@import AVFoundation;

@interface PlaySongViewController () <AVAudioPlayerDelegate> 

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) AVAudioPlayer *backgroundMusicPlayer;

@end

@implementation PlaySongViewController
int _songNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"SongList", @"SongList") ofType:@"plist"];
    
    self.songList = [[NSArray alloc] initWithContentsOfFile:resourcePath];
    
    NSString *songName = [[NSString alloc] initWithFormat:@"sample%02d.mp3", self.songIndex+1];
    //NSLog(@"song title %@", songName);
    [self playBackgroundMusic:songName];

    if (self.songIndex > 0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reverse-32.png"] style:UIBarButtonItemStylePlain target:self action:@selector(reverseTapped:)];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home-32.png"] style:UIBarButtonItemStylePlain target:self action:@selector(returnHome:)];
    }

    if (self.songIndex + 1 < self.songList.count) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward-32.png"] style:UIBarButtonItemStylePlain target:self action:@selector(fastForwardTapped:)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home-32.png"] style:UIBarButtonItemStyleDone target:self action:@selector(returnHome:)];
    }
    
    self.navigationItem.title = [[self.songList objectAtIndex:self.songIndex] objectForKey:@"engChapTitle"];
    //NSLog(@"song title %@", _songTitle);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"DidReceiveMemoryWarning");
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *imageName = [NSString stringWithFormat:@"NTD-sample%02d.jpg", self.songIndex+1];
    self.imageView.image = [UIImage imageNamed:imageName];
}

- (void)playBackgroundMusic:(NSString *)filename{
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    
    //NSLog(@"%@\n", backgroundMusicURL);
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc]
                                  initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.delegate = self;  // We need this so we can restart after interruptions
    self.backgroundMusicPlayer.numberOfLoops = -1;
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}


#pragma mark - Supporting functions
-(void)returnHome:(id)sender
{
    [self.backgroundMusicPlayer stop];
    self.songIndex = - 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)goHomeTapped:(id)sender {
    [self.backgroundMusicPlayer stop];
    self.songIndex = - 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)fastForwardTapped:(id)sender
{
    [self.backgroundMusicPlayer stop];
    self.songIndex = self.songIndex + 1;
    [self performSegueWithIdentifier:@"PlayNextSong" sender:self];
}

- (void)reverseTapped:(id)sender
{
    [self.backgroundMusicPlayer stop];
    self.songIndex = self.songIndex - 1;
    [self performSegueWithIdentifier:@"PlayPreviousSong" sender:self];
}

- (IBAction)toITunesStore:(id)sender {
    [self.backgroundMusicPlayer stop];
    self.songIndex = - 1;
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSString *iTunesLink = @"itms://itunes.apple.com/us/album/khong-gio-roi/id340412053?uo=4";
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString:iTunesLink] options:@{} completionHandler:nil];
}

- (IBAction)toASIAStore:(id)sender {
    [self.backgroundMusicPlayer stop];
    self.songIndex = - 1;
    [self.navigationController popToRootViewControllerAnimated:NO];
    NSString *aSIALink = @"https://www.bacmymarket.com/product-p/music08.htm";
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:[NSURL URLWithString:aSIALink] options:@{} completionHandler:nil];
}

- (IBAction)close:(UIStoryboardSegue *)segue {
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayNextSong"]) {
        PlaySongViewController * playSongViewController = (PlaySongViewController*)segue.destinationViewController;
        playSongViewController.songIndex  = self.songIndex;
    } else if ([segue.identifier isEqualToString:@"PlayPreviousSong"]) {
        PlaySongViewController * playSongViewController = (PlaySongViewController*)segue.destinationViewController;
        playSongViewController.songIndex  = self.songIndex;
    }
}

@end
