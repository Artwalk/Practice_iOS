//
//  ViewController.m
//  12.8.Music Library
//
//  Created by artwalk on 8/17/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <MPMediaPickerControllerDelegate, AVAudioPlayerDelegate>

@property (nonatomic, strong) MPMediaPickerController *mediaPicker;
@property (nonatomic, strong) MPMusicPlayerController *myMusicPlayer;
@property (weak, nonatomic) IBOutlet UIButton *pickAndPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *stopPlayingButton;


@end

@implementation ViewController

- (IBAction)displayMediaPickerAndPlayItem:(id)sender {
    self.mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeAnyAudio];
    
    if (self.mediaPicker != nil) {
        self.mediaPicker.delegate = self;
        self.mediaPicker.allowsPickingMultipleItems = YES;
        self.mediaPicker.showsCloudItems = YES;
        self.mediaPicker.prompt = @"Pick a song please...";
        
        [self.view addSubview:self.mediaPicker.view];
        [self.navigationController pushViewController:self.mediaPicker animated:YES];
//        [self.navigationController presentViewController:self.mediaPicker animated:YES completion:nil];
    }
    
}

- (IBAction)stopPlayingAudio:(id)sender {
    if (self.myMusicPlayer != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.myMusicPlayer];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.myMusicPlayer];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerVolumeDidChangeNotification object:self.myMusicPlayer];
        
        [self.myMusicPlayer stop];
    }
    
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


- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    
    self.myMusicPlayer = nil;
    self.myMusicPlayer = [[MPMusicPlayerController alloc] init];
    [self.myMusicPlayer beginGeneratingPlaybackNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayerStateChanged:) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:self.myMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nowPlayingItemIsChanged:) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:self.myMusicPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeIsChanged:) name:MPMusicPlayerControllerVolumeDidChangeNotification object:self.myMusicPlayer];
    
    [self.myMusicPlayer setQueueWithItemCollection:mediaItemCollection];
    [self.myMusicPlayer play];
    
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) musicPlayerStateChanged:(NSNotification *)notification {
    NSNumber *stateAsObject = [notification.userInfo objectForKey:@"MPMusicPlayerControllerPlaybackStateKey"];
    
    NSInteger state = [stateAsObject integerValue];
    
    switch (state){
        case MPMusicPlaybackStateStopped:{
            NSLog(@" Here the media player has stopped playing the queue. ");
            break; }
        case MPMusicPlaybackStatePlaying:{
            NSLog(@" The media player is playing the queue. Perhaps you can reduce some processing that your application that is using to give more processing power to the media player ");
            break; }
        case MPMusicPlaybackStatePaused:{
            NSLog(@" The media playback is paused here. You might want to indicate by showing graphics to the user ");
            break; }
        case MPMusicPlaybackStateInterrupted:{
            NSLog(@" An interruption stopped the playback of the media queue "); break;
        }
        case MPMusicPlaybackStateSeekingForward:{
            NSLog(@" The user is seeking forward in the queue ");
            break; }
        case MPMusicPlaybackStateSeekingBackward:{
            NSLog(@" The user is seeking backward in the queue "); break;
        }
    }
}

- (void)nowPlayingItemIsChanged:(NSNotification *)notification {
    NSString *persistentID = [notification.userInfo objectForKey:@"MPMusicPlayerControllerNowPlayingItemPersistentIDKey"];
    
    NSLog(@"persistentID --> %@", persistentID);
}

- (void)volumeIsChanged:(NSNotification *)notification {
    NSLog(@"Volume Is Changed");
}

@end
